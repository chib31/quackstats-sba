package uk.cbradbury.quackstats.entities;

import lombok.Data;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@Data
public class StatResponse {
  private Map<String, String> statInfo;
  private List<LinkedHashMap<String, Object>> columnList;
  private List<?> dataList;

  public StatResponse(Map<String, String> statInfo, List<LinkedHashMap<String, Object>> columnList, List<?> dataList) {
    this.statInfo = statInfo;
    this.columnList = columnList;
    this.dataList = dataList;
  }
}
