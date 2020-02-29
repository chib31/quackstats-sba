package uk.cbradbury.quackstats.entities;

import uk.cbradbury.quackstats.enumerations.Column;

import java.util.Set;
import java.util.stream.Collectors;

public class StatColumn {
  private Column column;
  private Integer displayOrder;
  private Integer aggDisplayOrder;
  private Integer sortOrder;
  private Set<SelectFilter> selectFilters;

  public StatColumn(Column column, Integer displayOrder, Integer aggDisplayOrder, Integer sortOrder,
                    Set<String> selectFilters) {
    this.column = column;
    this.displayOrder = displayOrder;
    this.aggDisplayOrder = aggDisplayOrder;
    this.sortOrder = sortOrder;
    this.selectFilters = (selectFilters == null)
        ? Set.of()
        : selectFilters.stream().map(SelectFilter::new).collect(Collectors.toSet());
  }

  public StatColumn(Column column, Integer displayOrder, Integer aggDisplayOrder) {
    this(column, displayOrder, aggDisplayOrder, null, Set.of());
  }

  public Column getColumn() {
    return column;
  }

  public Integer getDisplayOrder() {
    return displayOrder;
  }

  public Integer getAggDisplayOrder() {
    return aggDisplayOrder;
  }

  public Integer getSortOrder() {
    return sortOrder;
  }

  public Set<SelectFilter> getSelectFilters() {
    return selectFilters;
  }

  static class SelectFilter {
    private String value;

    private SelectFilter(String value) {
      this.value = value;
    }

    public String getValue() {
      return this.value;
    }
  }
}
