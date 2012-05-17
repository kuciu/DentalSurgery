package pl.poznan.put.dentalsurgery.service;

import java.util.Collection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import pl.poznan.put.dentalsurgery.model.VisitActivity;
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
	public void setToothActivityDictDao(
			final ToothActivityDictDao toothActivityDictDao) {
		this.toothActivityDictDao = toothActivityDictDao;
	}

	@Autowired
	public void setToothStateDictDao(final ToothStateDictDao toothStateDictDao) {
		this.toothStateDictDao = toothStateDictDao;
	}

	@Autowired
	public void setVisitActivityDictDao(
			final VisitActivityDictDao visitActivityDictDao) {
		this.visitActivityDictDao = visitActivityDictDao;
	}

	@Override
	@Transactional(readOnly = true)
	public DictTransferObject getAllDictionaries() {
		final DictTransferObject transferObject = new DictTransferObject();
		transferObject.setToothActivities(toothActivityDictDao
				.getAllToothActivities());
		transferObject.setToothStates(toothStateDictDao.getAllToothStates());
		transferObject.setVisitActivities(visitActivityDictDao
				.getAllVisitActivities());
		return transferObject;
	}

	@Override
	@Transactional
	public Collection<VisitActivity> getVisitActivityDict() {
		return visitActivityDictDao.getAllVisitActivities();
	}

	@Override
	@Transactional
	public void addVisitActivity(final VisitActivity activity) {
		visitActivityDictDao.addVisitActivity(activity);
	}

	@Override
	@Transactional
	public VisitActivity getVisitActivityById(final Long activityId) {
		return visitActivityDictDao.getVisitActivityById(activityId);
	}

	@Override
	@Transactional
	public void updateVisitActivity(final VisitActivity activity) {
		visitActivityDictDao.updateVisitActivity(activity);
	}

	@Override
	@Transactional
	public void deleteVisitActivity(final VisitActivity visitActivity) {
		visitActivityDictDao.deleteVisitActivity(visitActivity);
	}
}
