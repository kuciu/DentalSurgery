package pl.poznan.put.dentalsurgery.service;

import java.util.Collection;

import pl.poznan.put.dentalsurgery.model.SimpleEntity;
import pl.poznan.put.dentalsurgery.repository.SimpleEntityDao;

public class SimpleEntityServiceImpl implements SimpleEntityService {

	private SimpleEntityDao simpleEntityDao;

	public void setSimpleEntityDao(SimpleEntityDao simpleEntityDao) {
		this.simpleEntityDao = simpleEntityDao;
	}

	public Collection<SimpleEntity> loadAllEntities() {
		return simpleEntityDao.loadAllEntities();
	}

}
