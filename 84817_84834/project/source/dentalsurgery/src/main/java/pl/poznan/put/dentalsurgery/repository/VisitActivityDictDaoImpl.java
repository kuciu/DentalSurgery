package pl.poznan.put.dentalsurgery.repository;

import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Repository;

import pl.poznan.put.dentalsurgery.model.VisitActivity;

@Repository
public class VisitActivityDictDaoImpl extends AbstractDao<VisitActivity>
		implements VisitActivityDictDao {

	@Override
	public long addVisitActivity(final VisitActivity visitActivity) {
		return (Long) sessionFactory.getCurrentSession().save(visitActivity);
	}

	@Override
	public void deleteVisitActivity(final VisitActivity visitActivity) {
		sessionFactory.getCurrentSession().delete(visitActivity);
	}

	@Override
	public void updateVisitActivity(final VisitActivity visitActivity) {
		sessionFactory.getCurrentSession().update(visitActivity);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<VisitActivity> getAll() {
		return this.sessionFactory.getCurrentSession()
				.createQuery("from VisitActivity").list();
	}

	@Override
	public List<VisitActivity> getAllVisitActivities() {
		return getAll();
	}

	@Override
	public VisitActivity getVisitActivityById(final long visitActivityId) {
		return (VisitActivity) sessionFactory.getCurrentSession().get(
				VisitActivity.class, visitActivityId);
	}

	/**
	 * Zbiór czynności ładuje z bazy danych; przy ładowaniu bierze pod uwagę
	 * tylko identyfikator czynności, cała reszta jest nadpisywana
	 * @param setOfActivities
	 */
	@Override
	public void loadPersistentSetOfActivities(Set<VisitActivity> setOfActivities) {
		for (VisitActivity activity: setOfActivities) {
			sessionFactory.getCurrentSession().load(activity, activity.getActivityId());
		}
		
	}

}
