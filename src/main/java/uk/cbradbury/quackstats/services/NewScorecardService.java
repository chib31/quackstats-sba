package uk.cbradbury.quackstats.services;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import uk.cbradbury.quackstats.entities.Player;
import uk.cbradbury.quackstats.entities.StatColumn;
import uk.cbradbury.quackstats.entities.StatResponse;
import uk.cbradbury.quackstats.enumerations.Column;
import uk.cbradbury.quackstats.enumerations.StatType;
import uk.cbradbury.quackstats.respositories.PlayerRepository;

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
public class NewScorecardService {

  private final EntityManager em;
  private final int TEAM_ID = 1;

  @Autowired
  public NewScorecardService(EntityManager em) {
    this.em = em;
  }

//  public List<Player> fetchPlayers() {
//    return playerRepository.
//  }
}
