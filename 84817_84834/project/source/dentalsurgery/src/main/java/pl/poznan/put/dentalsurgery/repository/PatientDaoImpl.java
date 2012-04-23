package pl.poznan.put.dentalsurgery.repository;

import java.util.Collection;
import java.util.List;

import org.springframework.stereotype.Repository;

import pl.poznan.put.dentalsurgery.model.Patient;

@Repository
public class PatientDaoImpl extends AbstractDao<Patient> implements PatientDao {

	@Override
	public void deletePatient(final Patient patient) {
		this.sessionFactory.getCurrentSession().delete(patient);

	}

	@Override
	public long addPatient(final Patient patient) {
		return (Long) this.sessionFactory.getCurrentSession().save(patient);
	}

	@Override
	public Patient getPatientById(final Long patientId) {
		return (Patient) sessionFactory.getCurrentSession().get(Patient.class,
				patientId);
	}

	@Override
	public void updateUser(final Patient patient) {
		sessionFactory.getCurrentSession().update(patient);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Patient> getAll() {
		return this.sessionFactory.getCurrentSession()
				.createQuery("from Patient").list();
	}

	@Override
	public Collection<Patient> getAllPatients() {
		return getAll();
	}

}
