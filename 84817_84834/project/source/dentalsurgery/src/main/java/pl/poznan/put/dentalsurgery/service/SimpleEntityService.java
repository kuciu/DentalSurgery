package pl.poznan.put.dentalsurgery.service;

import java.util.Collection;

import pl.poznan.put.dentalsurgery.model.SimpleEntity;

/**
 * Przykładowy interfejs warstwy biznesowej
 * 
 * @author Tomasz Kamiński
 * 
 */
public interface SimpleEntityService {

	public Collection<SimpleEntity> loadAllEntities();

}
