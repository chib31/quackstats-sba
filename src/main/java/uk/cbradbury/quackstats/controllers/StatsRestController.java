package uk.cbradbury.quackstats.controllers;

import org.springframework.web.bind.annotation.*;
import uk.cbradbury.quackstats.entities.StatResponse;
import uk.cbradbury.quackstats.enumerations.StatType;
import uk.cbradbury.quackstats.services.StatsService;

@RestController()
@CrossOrigin(maxAge = 3600)
@RequestMapping("/api")
public class StatsRestController {

  private final StatsService statsService;

  public StatsRestController(StatsService statsService) {
    this.statsService = statsService;
  }

  @RequestMapping(path = "/stats")
  public @ResponseBody
  StatResponse fetchReport(@RequestParam StatType statType) {
    return statsService.fetchStats(statType);
  }
}
