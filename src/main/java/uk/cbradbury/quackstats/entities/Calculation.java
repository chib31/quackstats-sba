package uk.cbradbury.quackstats.entities;

import uk.cbradbury.quackstats.enumerations.Column;

public class Calculation {
  private String numeratorKey;
  private String denominatorKey;
  private int multiplier;

  public Calculation(Column numerator, Column denominator, int multiplier) {
    this.numeratorKey = numerator.getKey();
    this.denominatorKey = denominator.getKey();
    this.multiplier = multiplier;
  }

  public Calculation(Column denominator, int multiplier) {
    this.numeratorKey = null;
    this.denominatorKey = denominator.getKey();
    this.multiplier = multiplier;
  }

  public String getNumeratorKey() {
    return numeratorKey;
  }

  public String getDenominatorKey() {
    return denominatorKey;
  }

  public int getMultiplier() {
    return multiplier;
  }
}
