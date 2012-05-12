package pl.poznan.put.dentalsurgery.service;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import pl.poznan.put.dentalsurgery.model.Visit;
import pl.poznan.put.dentalsurgery.repository.VisitDao;

@Service
public class VisitServiceImpl implements VisitService {
	
	private static final Log LOGGER = LogFactory
			.getLog(VisitServiceImpl.class);
	
	private VisitDao visitDao;
	
	@Autowired
	public void setVisitDao(VisitDao visitDao) {
		this.visitDao = visitDao;
	}
	
	@Override
	@Transactional(readOnly = true)
	public Visit getVisidById(Long visitId) {
		return visitDao.getVisitById(visitId);
	}

}
