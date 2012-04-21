package pl.poznan.put.dentalsurgery.service;

import java.util.Collection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import pl.poznan.put.dentalsurgery.model.SimpleEntity;
import pl.poznan.put.dentalsurgery.repository.SimpleEntityDao;

@Service 
public class SimpleEntityServiceImpl implements SimpleEntityService {
	
	protected final Log logger = LogFactory.getLog(getClass());
	private SimpleEntityDao simpleEntityDao;

	@Autowired
	public void setSimpleEntityDao(SimpleEntityDao simpleEntityDao) {
		this.simpleEntityDao = simpleEntityDao;
	}

	@Transactional(readOnly = true)
	public Collection<SimpleEntity> loadAllEntities() {
		logger.info("Jestem w SimpleEntityServiceImpl.loadAllEntities!!! :)");
		return simpleEntityDao.loadAllEntities();
	}

}
