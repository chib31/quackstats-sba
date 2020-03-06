package uk.cbradbury.quackstats.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uk.cbradbury.quackstats.entities.StatColumn;
import uk.cbradbury.quackstats.entities.StatResponse;
import uk.cbradbury.quackstats.enumerations.Column;
import uk.cbradbury.quackstats.enumerations.StatType;

import javax.persistence.EntityManager;
import javax.persistence.Tuple;
import javax.persistence.TupleElement;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class StatsService {

  private final EntityManager em;
  private final int TEAM_ID = 1;

  @Autowired
  public StatsService(EntityManager em) {
    this.em = em;
  }

  public StatResponse fetchStats(StatType statType) {
    List<StatColumn> statColumns = statType.columns;

    List<Column> columns = statColumns.stream().map(StatColumn::getColumn).collect(Collectors.toList());

    List<Column> selectColumns = columns.stream()
        .filter(Column::getRawValue)
        .collect(Collectors.toList());

    StringBuilder sb = new StringBuilder();

    sb.append("SELECT ");
    List<String> selectFields = new ArrayList<>();
    for (Column column : selectColumns) {
      selectFields.add("t." + column.getKey() + " AS " + column.getKey());
    }
    sb.append(String.join(", ", selectFields));
    sb.append(" FROM ").append(statType.dbTableName).append(" t ");
    sb.append(" WHERE t.team_id = ").append(TEAM_ID);

    @SuppressWarnings("unchecked")
    List<Tuple> tupleList = em.createNativeQuery(sb.toString(), Tuple.class).getResultList();

    List<ObjectNode> resultList = tupleToObjectNodes(tupleList);

    return new StatResponse(
        constructStatInfoMap(statType),
        constructColumnsJson(statColumns),
        resultList);
  }

  private HashMap<String, String> constructStatInfoMap(StatType statType) {
    HashMap<String, String> reportInfo = new HashMap<>();
    reportInfo.put("stat_type", statType.toString());
    return reportInfo;
  }

  private List<LinkedHashMap<String, Object>> constructColumnsJson(List<StatColumn> statColumns) {
    List<LinkedHashMap<String, Object>> columnList = new ArrayList<>();
    for (StatColumn sCol : statColumns) {
      LinkedHashMap<String, Object> map = new LinkedHashMap<>();
      Column col = sCol.getColumn();

      map.put("key", col.getKey());
      map.put("label", col.getLabel());
      map.put("rawValue", col.getRawValue());
      map.put("viewability", col.getViewability());
      map.put("display", col.getDisplay());
      map.put("filterable", col.getFilterable());
      map.put("rangeable", col.getRangeable());
      map.put("sortType", col.getSortType());
      map.put("formatter", col.getFormatter());
      map.put("groupable", col.getGroupable());
      map.put("grouped", col.getGrouped());
      map.put("aggLabel", col.getAggLabel());
      map.put("aggregateType", col.getAggregateType());
      map.put("aggCalculation", col.getAggCalculation());
      map.put("aggViewability", col.getAggViewability());
      map.put("aggDisplay", col.getAggDisplay());
      map.put("aggRangeable", col.getAggRangeable());
      map.put("filterRange", List.of());

      map.put("displayOrder", sCol.getDisplayOrder());
      map.put("aggDisplayOrder", sCol.getAggDisplayOrder());
      map.put("sortPriority", sCol.getSortOrder());
      map.put("selectFilters", sCol.getSelectFilters().size() > 0 ? sCol.getSelectFilters() : null);

      columnList.add(map);
    }
    return columnList;
  }

  private List<ObjectNode> tupleToObjectNodes(List<Tuple> results) {
    List<ObjectNode> json = new ArrayList<>();
    ObjectMapper mapper = new ObjectMapper();
    for (Tuple t : results) {
      List<TupleElement<?>> cols = t.getElements();
      ObjectNode on = mapper.createObjectNode();
      for (TupleElement col : cols) {
        String key = col.getAlias();
        Class c = col.getJavaType();
        if(Integer.class.isAssignableFrom(c)) {
          Integer value = (Integer) t.get(key);
          on.put(key, value);
        } else if(c == BigDecimal.class) {
          Double value = ((BigDecimal) t.get(key)).doubleValue();
          on.put(key, value);
        } else {
          var value = t.get(col.getAlias()) == null ? null : t.get(col.getAlias()).toString();
          on.put(col.getAlias(), value);
        }
      }
      json.add(on);
    }
    return json;
  }
}
