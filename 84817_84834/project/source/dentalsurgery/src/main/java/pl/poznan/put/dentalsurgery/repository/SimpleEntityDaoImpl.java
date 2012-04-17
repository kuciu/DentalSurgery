package pl.poznan.put.dentalsurgery.repository;

import java.util.Collection;
import pl.poznan.put.dentalsurgery.model.SimpleEntity;
import org.hibernate.SessionFactory;

public class SimpleEntityDaoImpl implements SimpleEntityDao {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }
	
	public Collection<SimpleEntity> loadAllEntities() {
		return this.sessionFactory.getCurrentSession()
                .createQuery("from SimpleEntity")
                .list();
	}

}
