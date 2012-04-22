package pl.poznan.put.dentalsurgery.repository;

import java.util.Collection;

import org.hibernate.SessionFactory;

import pl.poznan.put.dentalsurgery.model.Patient;

public class PatientDaoImpl implements PatientDao {

	private SessionFactory sessionFactory;

	public void setSessionFactory(final SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Collection<Patient> loadAllPatients() {
		return this.sessionFactory.getCurrentSession()
				.createQuery("from Patient").list();
	}

}
