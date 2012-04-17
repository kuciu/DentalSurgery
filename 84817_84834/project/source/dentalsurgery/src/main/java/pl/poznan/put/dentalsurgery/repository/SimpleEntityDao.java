package pl.poznan.put.dentalsurgery.repository;

import java.util.Collection;
import pl.poznan.put.dentalsurgery.model.SimpleEntity;

/**
 * Prosty interfejs DAO
 * 
 * @author Tomasz Kamiński
 * 
 */
public interface SimpleEntityDao {

	public Collection<SimpleEntity> loadAllEntities();

}
