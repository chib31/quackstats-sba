package uk.cbradbury.quackstats.enumerations;

import uk.cbradbury.quackstats.entities.Calculation;
import uk.cbradbury.quackstats.enumerations.column_meta.AggregateType;
import uk.cbradbury.quackstats.enumerations.column_meta.SortType;
import uk.cbradbury.quackstats.enumerations.column_meta.Viewability;

import static uk.cbradbury.quackstats.enumerations.column_meta.AggregateType.*;
import static uk.cbradbury.quackstats.enumerations.column_meta.SortType.ASC;
import static uk.cbradbury.quackstats.enumerations.column_meta.SortType.DESC;
import static uk.cbradbury.quackstats.enumerations.column_meta.Viewability.*;

public enum Column {

  BOWLER_NUMBER("bowler_number","Bowler Number",true,OPTIONAL,false,true,ASC,"dec2NoTrail",true,false,"Avg Bowler Number",MEAN,null,OPTIONAL,false,false,false),
  CATCHES("catches","Catches",true,OPTIONAL,true,false,DESC,null,false,false,"Catches",SUM,null,OPTIONAL,true,true,true),
  DATE("date","Date",true,OPTIONAL,false,false,DESC,null,false,false,null,null,null,ALWAYS_HIDE,false,false,false),
  DELIVERIES("deliveries","Deliveries",true,OPTIONAL,true,false,DESC,null,false,false,"Deliveries",SUM,null,OPTIONAL,true,true,true),
  FIELDING_MATCHES("fielding_matches","Matches",true,ALWAYS_HIDE,false,false,ASC,null,false,false,"Matches",SUM,null,OPTIONAL,true,false,true),
  FIELDING_WICKETS("fielding_wickets","Wickets",true,OPTIONAL,true,false,DESC,null,false,false,"Wickets",SUM,null,OPTIONAL,true,true,true),
  FIXTURE("fixture","Fixture",true,OPTIONAL,true,false,null,null,true,false,null,null,null,ALWAYS_HIDE,false,false,false),
  FOURS("fours","Fours",true,OPTIONAL,true,false,DESC,null,false,false,"Fours",SUM,null,OPTIONAL,true,true,true),
  GROUP_TERM("group_term",null,false,ALWAYS_HIDE,false,false,null,null,false,false,"GROUP_TERM",null,null,ALWAYS_SHOW,true,false,false),
  HAT_TRICKS("hat_tricks","Hat Tricks",true,OPTIONAL,false,false,DESC,null,false,false,"Hat Tricks",SUM,null,OPTIONAL,false,false,false),
  ID("id",null,true,ALWAYS_HIDE,false,false,null,null,false,false,null,null,null,ALWAYS_HIDE,false,false,false),
  INDEX("index","#",false,ALWAYS_SHOW,true,false,null,null,false,false,"#",null,null,ALWAYS_SHOW,true,false,false),
  INNINGS("innings",null,true,ALWAYS_HIDE,false,false,DESC,null,false,false,"Innings",SUM,null,OPTIONAL,true,false,true),
  INNINGS_LENGTH("innings_length","Innings Length",true,OPTIONAL,true,false,DESC,null,false,false,null,null,null,ALWAYS_HIDE,false,true,true),
  MAIDENS("maidens","Maidens",true,OPTIONAL,false,false,DESC,null,false,false,"Maidens",SUM,null,OPTIONAL,false,true,true),
  MATCH_FORMAT("match_format","Match Format",true,OPTIONAL,false,true,null,null,false,false,null,null,null,ALWAYS_HIDE,false,false,false),
  NOT_OUTS("not_outs",null,true,ALWAYS_HIDE,false,false,null,null,false,false,"Not Outs",SUM,null,OPTIONAL,false,false,true),
  NO_BALLS("no_balls","No Balls",true,OPTIONAL,true,false,DESC,null,false,false,"No Balls",SUM,null,OPTIONAL,false,true,true),
  OPPOSITION("opposition","Opposition",true,OPTIONAL,false,true,null,null,true,false,null,null,null,ALWAYS_HIDE,false,false,false),
  OVERS("overs","Overs",true,OPTIONAL,false,false,null,null,false,false,null,null,null,ALWAYS_HIDE,false,false,false),
  OVER_LENGTH("over_length","Over Length",true,OPTIONAL,false,false,null,null,false,false,null,null,null,ALWAYS_HIDE,false,false,false),
  PERCENT_TOTAL("percent_total","% of Total",true,OPTIONAL,false,false,DESC,"percent1Always",false,false,null,null,null,ALWAYS_HIDE,false,true,false),
  PLAYER_NAME("player_name","Player",true,ALWAYS_SHOW,true,true,ASC,null,true,false,null,null,null,ALWAYS_HIDE,false,false,false),
  POSITION("position","Position",true,OPTIONAL,false,true,ASC,"dec2NoTrail",true,false,"Avg Position",MEAN,null,OPTIONAL,false,false,true),
  RESULT("result","Result",true,OPTIONAL,false,true,null,null,true,false,null,null,null,ALWAYS_HIDE,false,false,false),
  RUNS("runs","Runs",true,OPTIONAL,true,false,DESC,null,false,false,"Runs",SUM,null,OPTIONAL,true,true,true),
  RUN_OUTS("run_outs","Run Outs",true,OPTIONAL,true,false,DESC,null,false,false,"Run Outs",SUM,null,OPTIONAL,true,true,true),
  SEASON("season","Season",true,OPTIONAL,false,true,DESC,null,true,false,null,null,null,ALWAYS_HIDE,false,false,false),
  SIXES("sixes","Sixes",true,OPTIONAL,true,false,DESC,null,false,false,"Sixes",SUM,null,OPTIONAL,true,true,true),
  STUMPINGS("stumpings","Stumpings",true,OPTIONAL,true,false,DESC,null,false,false,"Stumpings",SUM,null,OPTIONAL,true,true,true),
  TEAM_TOTAL("team_total","Team Total",true,OPTIONAL,false,false,null,null,false,false,null,SUM,null,ALWAYS_HIDE,false,false,false),
  WICKETS_BATTING("wickets_batting",null,true,ALWAYS_HIDE,false,false,null,null,false,false,"Wickets",SUM,null,OPTIONAL,true,false,false),
  WICKETS_BOWLING("wickets_bowling","Wickets",true,OPTIONAL,true,false,DESC,null,false,false,"Wickets",SUM,null,OPTIONAL,true,true,true),
  WICKET_TYPE("wicket_type","Wicket Type",true,OPTIONAL,true,true,null,null,true,false,null,null,null,ALWAYS_HIDE,false,false,false),
  WIDES("wides","Wides",true,OPTIONAL,true,false,DESC,null,false,false,"Wides",SUM,null,OPTIONAL,false,true,true),
  // Complex columns (must go here to avoid forward references),
  AVERAGE_BAT("average_bat",null,false,ALWAYS_HIDE,false,false,DESC,"dec2Always",false,false,"Average",COMPLEX,new Calculation(RUNS, WICKETS_BATTING, 1),OPTIONAL,true,false,false),
  AVERAGE_BOWL("average_bowl","Average",true,OPTIONAL,true,false,ASC,"dec2Always",false,false,"Average",COMPLEX,new Calculation(RUNS, WICKETS_BOWLING, 1),OPTIONAL,true,false,false),
  ECONOMY("economy","Economy",true,OPTIONAL,true,false,ASC,"dec2Always",false,false,"Economy",COMPLEX,new Calculation(RUNS, DELIVERIES, 6),OPTIONAL,true,false,true),
  STRIKE_RATE_BAT("strike_rate_bat","Strike Rate",true,OPTIONAL,true,false,DESC,"dec2Always",false,false,"Strike Rate",COMPLEX,new Calculation(RUNS, DELIVERIES, 100),OPTIONAL,true,true,true),
  STRIKE_RATE_BOWL("strike_rate_bowl","Strike Rate",true,OPTIONAL,true,false,ASC,"dec2Always",false,false,"Strike Rate",COMPLEX,new Calculation(DELIVERIES, WICKETS_BOWLING, 1),OPTIONAL,true,true,true);

  private final String key;
  private final String label;
  private final Boolean rawValue;
  private final Viewability viewability;
  private final boolean display;
  private final boolean filterable;
  private final SortType sortType;
  private final String formatter;
  private final boolean groupable;
  private final boolean grouped;
  private final String aggLabel;
  private final AggregateType aggregateType;
  private final Calculation aggCalculation;
  private final Viewability aggViewability;
  private final boolean aggDisplay;
  private final boolean rangeable;
  private final boolean aggRangeable;

  Column(String key,String label,Boolean rawValue,Viewability viewability,boolean display,boolean filterable,SortType sortType,String formatter,boolean groupable,boolean grouped,String aggLabel,AggregateType aggregateType,Calculation aggCalculation,Viewability aggViewability,boolean aggDisplay,boolean rangeable,boolean aggRangeable) {
    this.key = key;
    this.label = label;
    this.rawValue = rawValue;
    this.viewability = viewability;
    this.display = display;
    this.filterable = filterable;
    this.sortType = sortType;
    this.formatter = formatter;
    this.groupable = groupable;
    this.grouped = grouped;
    this.aggLabel = aggLabel;
    this.aggregateType = aggregateType;
    this.aggCalculation = aggCalculation;
    this.aggViewability = aggViewability;
    this.aggDisplay = aggDisplay;
    this.rangeable = rangeable;
    this.aggRangeable = aggRangeable;
  }

  public String getKey() {
  return this.key;
  }

  public String getLabel() {
  return this.label;
  }

  public Boolean getRawValue() {
  return this.rawValue;
  }

  public Viewability getViewability() {
  return this.viewability;
  }

  public boolean getDisplay() {
  return this.display;
  }

  public boolean getFilterable() {
  return this.filterable;
  }

  public SortType getSortType() {
  return this.sortType;
  }

  public String getFormatter() {
  return this.formatter;
  }

  public boolean getGroupable() {
  return this.groupable;
  }

  public boolean getGrouped() {
  return this.grouped;
  }

  public String getAggLabel() {
  return this.aggLabel;
  }

  public AggregateType getAggregateType() {
  return this.aggregateType;
  }

  public Calculation getAggCalculation() {
  return this.aggCalculation;
  }

  public Viewability getAggViewability() {
  return this.aggViewability;
  }

  public boolean getAggDisplay() {
  return this.aggDisplay;
  }

  public boolean getRangeable() {
  return this.rangeable;
  }

  public boolean getAggRangeable() {
  return this.aggRangeable;
  }

}
