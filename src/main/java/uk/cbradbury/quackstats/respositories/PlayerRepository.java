package uk.cbradbury.quackstats.respositories;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import uk.cbradbury.quackstats.entities.Player;

@Repository
public interface PlayerRepository extends CrudRepository<Player, Long> {
}
