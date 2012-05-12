package pl.poznan.put.dentalsurgery.repository;

import java.util.Collection;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.springframework.stereotype.Repository;

import pl.poznan.put.dentalsurgery.model.Visit;

@Repository
public class VisitDaoImpl extends AbstractDao<Visit> implements VisitDao {

	@Override
	public Visit getVisitById(final Long visitId) {
		return (Visit) sessionFactory.getCurrentSession().get(Visit.class,
				visitId);
	}
	
	@Override
	public long addVisit(final Visit visit) {
		return (Long) this.sessionFactory.getCurrentSession().save(visit);
	}

	@Override
	public void updateVisit(final Visit visitFromDb) {
		sessionFactory.getCurrentSession().update(visitFromDb);		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Visit> getAll() {
		final Criteria criteria = this.sessionFactory.getCurrentSession()
				.createCriteria(Visit.class);
		criteria.addOrder(Order.desc("visitDate"));
		return criteria.list();
	}
	
	@Override
	public Collection<Visit> getAllVisits() {
		return getAll();
	}

}
