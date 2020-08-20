package uk.cbradbury.quackstats.controllers;

import org.springframework.web.bind.annotation.*;
import uk.cbradbury.quackstats.entities.StatResponse;
import uk.cbradbury.quackstats.services.NewScorecardService;

@RestController()
@CrossOrigin(maxAge = 3600)
@RequestMapping("/api")
public class NewScorecardRestController {

  private final NewScorecardService newScorecardService;

  public NewScorecardRestController(NewScorecardService newScorecardService) {
    this.newScorecardService = newScorecardService;
  }

//  @RequestMapping(path = "/playerList")
//  public @ResponseBody
//  StatResponse fetchPlayers() {
//    return newScorecardService.fetchPlayers();
//  }
}
