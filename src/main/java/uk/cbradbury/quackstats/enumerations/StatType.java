package uk.cbradbury.quackstats.enumerations;

import uk.cbradbury.quackstats.entities.StatColumn;

import java.util.List;
import java.util.Set;

import static uk.cbradbury.quackstats.enumerations.Column.*;

public enum StatType {
  BATTING(
      "player_batting_summary",
      List.of(
          new StatColumn(ID, null, null),
          new StatColumn(INDEX, 10, 10),
          new StatColumn(PLAYER_NAME, 20, null),
          new StatColumn(GROUP_TERM, null, 20),
          new StatColumn(AVERAGE_BAT, null, 30),
          new StatColumn(RUNS, 30, 40, 1, null),
          new StatColumn(DELIVERIES, 35, 45),
          new StatColumn(STRIKE_RATE_BAT, 40, 50, 2, null),
          new StatColumn(INNINGS, null, 60),
          new StatColumn(FOURS, 50, 70),
          new StatColumn(SIXES, 60, 80),
          new StatColumn(WICKET_TYPE, 70, 90),
          new StatColumn(POSITION, 80, 100),
          new StatColumn(PERCENT_TOTAL, 90, 110),
          new StatColumn(WICKETS_BATTING, 100, 120),
          new StatColumn(NOT_OUTS, null, 120),
          new StatColumn(FIXTURE, 110, null),
          new StatColumn(SEASON, 120, null, null, Set.of("2020")),
          new StatColumn(OPPOSITION, 130, null),
          new StatColumn(DATE, 140, null),
          new StatColumn(RESULT, 150, null),
          new StatColumn(TEAM_TOTAL, 160, null),
          new StatColumn(MATCH_FORMAT, 170, null),
          new StatColumn(OVER_LENGTH, 180, null)
      )
  ),
  BOWLING(
      "player_bowling_summary",
      List.of(
          new StatColumn(ID, null, null),
          new StatColumn(INDEX, 10, 10),
          new StatColumn(PLAYER_NAME, 20, null),
          new StatColumn(GROUP_TERM, null, 20),
          new StatColumn(DELIVERIES, 30, 30),
          new StatColumn(WICKETS_BOWLING, 40, 40, 1, null),
          new StatColumn(RUNS, 50, 50),
          new StatColumn(MAIDENS, 60, 60),
          new StatColumn(ECONOMY, 70, 70, 2, null),
          new StatColumn(AVERAGE_BOWL, 80, 80),
          new StatColumn(STRIKE_RATE_BOWL, 90, 90),
          new StatColumn(INNINGS, null, 100),
          new StatColumn(OVERS, 100, null),
          new StatColumn(WIDES, 110, 110),
          new StatColumn(NO_BALLS, 120, 120),
          new StatColumn(FIXTURE, 130, null),
          new StatColumn(SEASON, 140, null, null, Set.of("2020")),
          new StatColumn(OPPOSITION, 150, null),
          new StatColumn(DATE, 160, null),
          new StatColumn(RESULT, 170, null),
          new StatColumn(MATCH_FORMAT, 180, null),
          new StatColumn(OVER_LENGTH, 190, null),
          new StatColumn(VICTIM_RUNS, null, null),
          new StatColumn(VICTIM_POSITION, null, null),
          new StatColumn(AVG_VICTIM_POSITION, null, 130),
          new StatColumn(AVG_VICTIM_RUNS, null, 140)
      )
  ),
  FIELDING(
      "player_fielding_summary",
      List.of(
          new StatColumn(ID, null, null),
          new StatColumn(INDEX, 10, 10),
          new StatColumn(PLAYER_NAME, 20, null),
          new StatColumn(GROUP_TERM, null, 20),
          new StatColumn(CATCHES, 30, 30),
          new StatColumn(RUN_OUTS, 40, 40),
          new StatColumn(STUMPINGS, 50, 50),
          new StatColumn(FIELDING_WICKETS, 60, 60, 1, null),
          new StatColumn(FIXTURE, 70, null),
          new StatColumn(SEASON, 80, null, null, Set.of("2020")),
          new StatColumn(OPPOSITION, 90, null),
          new StatColumn(DATE, 100, null),
          new StatColumn(RESULT, 110, null),
          new StatColumn(MATCH_FORMAT, 120, null),
          new StatColumn(FIELDING_MATCHES, 120, null, null, null)
      )
  ),
  RESULTS (
      "fixture_summary",
      List.of (
          new StatColumn(ID, null, null),
          new StatColumn(SEASON, null, null),
          new StatColumn(FIXTURE, 10, null),
          new StatColumn(RESULT_DETAILS, 20, null)
      )
  )
  ;

  public final String dbTableName;
  public final List<StatColumn> columns;

  StatType(String dbTableName, List<StatColumn> columns) {
    this.dbTableName = dbTableName;
    this.columns = columns;
  }
}
