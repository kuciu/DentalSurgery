package pl.poznan.put.dentalsurgery.service;

import java.util.Collection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import pl.poznan.put.dentalsurgery.model.SimpleEntity;
import pl.poznan.put.dentalsurgery.repository.SimpleEntityDao;

public class SimpleEntityServiceImpl implements SimpleEntityService {
	protected final Log logger = LogFactory.getLog(getClass());

	private SimpleEntityDao simpleEntityDao;

	public void setSimpleEntityDao(SimpleEntityDao simpleEntityDao) {
		this.simpleEntityDao = simpleEntityDao;
	}

	public Collection<SimpleEntity> loadAllEntities() {
		logger.info("Jestem w SimpleEntityServiceImpl.loadAllEntities!!! :)");
		return simpleEntityDao.loadAllEntities();
	}

}
