package pl.poznan.put.dentalsurgery.service;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import pl.poznan.put.dentalsurgery.repository.ToothActivityDictDao;
import pl.poznan.put.dentalsurgery.repository.ToothStateDictDao;
import pl.poznan.put.dentalsurgery.repository.VisitActivityDictDao;

@Service
public class DictionaryServiceImpl implements DictionaryService {

	private static final Log LOGGER = LogFactory
			.getLog(DictionaryServiceImpl.class);

	private ToothActivityDictDao toothActivityDictDao;
	private ToothStateDictDao toothStateDictDao;
	private VisitActivityDictDao visitActivityDictDao;
	
	@Autowired
	public void setToothActivityDictDao(ToothActivityDictDao toothActivityDictDao) {
		this.toothActivityDictDao = toothActivityDictDao;
	}

	@Autowired
	public void setToothStateDictDao(ToothStateDictDao toothStateDictDao) {
		this.toothStateDictDao = toothStateDictDao;
	}

	@Autowired
	public void setVisitActivityDictDao(VisitActivityDictDao visitActivityDictDao) {
		this.visitActivityDictDao = visitActivityDictDao;
	}	
		
	@Override
	@Transactional(readOnly=true)
	public DictTransferObject getAllDictionaries() {
		DictTransferObject transferObject = new DictTransferObject();
		transferObject.setToothActivities(toothActivityDictDao
				.getAllToothActivities());
		transferObject.setToothStates(toothStateDictDao.getAllToothStates());
		transferObject.setVisitActivities(visitActivityDictDao
				.getAllVisitActivities());
		return transferObject;
	}
}
