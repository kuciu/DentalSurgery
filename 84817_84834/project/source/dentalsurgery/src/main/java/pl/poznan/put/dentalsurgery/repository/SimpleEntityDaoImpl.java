package pl.poznan.put.dentalsurgery.repository;

import java.util.Collection;
import pl.poznan.put.dentalsurgery.model.SimpleEntity;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class SimpleEntityDaoImpl implements SimpleEntityDao {

	private SessionFactory sessionFactory;

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@SuppressWarnings("unchecked")
	public Collection<SimpleEntity> loadAllEntities() {
		return this.sessionFactory.getCurrentSession()
				.createQuery("from SimpleEntity").list();
	}

}
