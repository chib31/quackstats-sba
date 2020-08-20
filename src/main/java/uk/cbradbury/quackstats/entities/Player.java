package uk.cbradbury.quackstats.entities;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Date;

@Entity
public class Player {

  @Id
  private long id;
  private String firstName;
  private String middleNames;
  private String lastName;
  private String preferredName;
  private String scorecardName;
  private long capNumber;
  private Date dateOfMembership;
  private long shirtNumber;

  protected Player() {}

  public long getId() {
    return id;
  }

  public void setId(long id) {
    this.id = id;
  }

  public String getFirstName() {
    return firstName;
  }

  public void setFirstName(String firstName) {
    this.firstName = firstName;
  }

  public String getMiddleNames() {
    return middleNames;
  }

  public void setMiddleNames(String middleNames) {
    this.middleNames = middleNames;
  }

  public String getLastName() {
    return lastName;
  }

  public void setLastName(String lastName) {
    this.lastName = lastName;
  }

  public String getPreferredName() {
    return preferredName;
  }

  public void setPreferredName(String preferredName) {
    this.preferredName = preferredName;
  }

  public String getScorecardName() {
    return scorecardName;
  }

  public void setScorecardName(String scorecardName) {
    this.scorecardName = scorecardName;
  }

  public long getCapNumber() {
    return capNumber;
  }

  public void setCapNumber(long capNumber) {
    this.capNumber = capNumber;
  }

  public Date getDateOfMembership() {
    return dateOfMembership;
  }

  public void setDateOfMembership(Date dateOfMembership) {
    this.dateOfMembership = dateOfMembership;
  }

  public long getShirtNumber() {
    return shirtNumber;
  }

  public void setShirtNumber(long shirtNumber) {
    this.shirtNumber = shirtNumber;
  }
}
