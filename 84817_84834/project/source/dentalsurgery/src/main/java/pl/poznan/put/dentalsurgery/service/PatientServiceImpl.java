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

	private static final Log LOGGER = LogFactory
			.getLog(PatientServiceImpl.class);

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
		return patientDao.getAllPatients();
	}

	@Override
	@Transactional(readOnly = true)
	public Patient getPatientById(final long patientId) {
		return patientDao.getPatientById(patientId);
	}

	@Override
	@Transactional
	public long addPatient(final Patient patient) {
		return patientDao.addPatient(patient);
	}

	@Override
	@Transactional
	public void deletePatient(final Patient patient) {
		this.patientDao.deletePatient(patient);
	}

}
