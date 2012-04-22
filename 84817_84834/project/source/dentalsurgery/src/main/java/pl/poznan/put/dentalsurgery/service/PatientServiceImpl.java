package pl.poznan.put.dentalsurgery.service;

import java.util.Collection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import pl.poznan.put.dentalsurgery.model.Patient;
import pl.poznan.put.dentalsurgery.repository.PatientDao;

@Service
public class PatientServiceImpl implements PatientService {

	protected final Log logger = LogFactory.getLog(getClass());

	private PatientDao patientDao;

	public PatientDao getPatientDao() {
		return patientDao;
	}

	@Autowired
	public void setPatientDao(final PatientDao patientDao) {
		this.patientDao = patientDao;
	}

	@Override
	@Transactional(readOnly = true)
	public Collection<Patient> getAllPatients() {
		return patientDao.loadAllPatients();
	}

	@Override
	public Collection<Patient> getPatientById(final long id) {
		// TODO Auto-generated method stub
		return null;
	}

}
