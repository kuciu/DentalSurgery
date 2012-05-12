package pl.poznan.put.dentalsurgery.service;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import pl.poznan.put.dentalsurgery.model.Visit;
import pl.poznan.put.dentalsurgery.model.VisitActivity;
import pl.poznan.put.dentalsurgery.repository.VisitActivityDictDaoImpl;
import pl.poznan.put.dentalsurgery.repository.VisitDao;

@Service
public class VisitServiceImpl implements VisitService {
	
	private static final Log LOGGER = LogFactory
			.getLog(VisitServiceImpl.class);
	
	private VisitDao visitDao;
	private VisitActivityDictDaoImpl visitActivityDictDao;
	
	@Autowired
	public void setVisitDao(VisitDao visitDao) {
		this.visitDao = visitDao;
	}

	@Autowired
	public void setVisitActivityDictDao(
			VisitActivityDictDaoImpl visitActivityDictDao) {
		this.visitActivityDictDao = visitActivityDictDao;
	}

	@Override
	@Transactional(readOnly = true)
	public Visit getVisidById(Long visitId) {
		return visitDao.getVisitById(visitId);
	}

	/**
	 * Dodaje nową wizytę do bazy danych
	 */
	@Override
	@Transactional
	public long addVisit(Visit visit) {

		// czynności dodane podczas tworzenia nowej wizyty trzeba ponownie załadować, ponieważ nie są
		// zarządzane przez hibernate'a
		visitActivityDictDao.loadPersistentSetOfActivities(visit.getActivities());
		
		// obiekty zębów będą utworzone zupełnie nowe, więc ich oczywiście nie czytamy z bazy
		
		return visitDao.addVisit(visit);
	}

}
