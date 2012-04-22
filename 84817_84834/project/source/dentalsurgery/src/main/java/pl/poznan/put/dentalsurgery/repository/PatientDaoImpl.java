package pl.poznan.put.dentalsurgery.repository;

import java.util.Collection;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import pl.poznan.put.dentalsurgery.model.Patient;

@Repository
public class PatientDaoImpl implements PatientDao {

	private SessionFactory sessionFactory;

	@Autowired
	public void setSessionFactory(final SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Collection<Patient> loadAllPatients() {

		return this.sessionFactory.getCurrentSession()
				.createQuery("from Patient").list();
	}

	@Override
	public void deletePatient(final Patient patient) {
		this.sessionFactory.getCurrentSession().delete(patient);

	}

	@Override
	public long addPatient(final Patient patient) {
		return (Long) this.sessionFactory.getCurrentSession().save(patient);
	}

	@Override
	public Patient getPatientById(final Long id) {
		return (Patient) sessionFactory.getCurrentSession().get(Patient.class,
				id);
	}

	@Override
	public void updateUser(final Patient patient) {
		sessionFactory.getCurrentSession().update(patient);
	}

}
