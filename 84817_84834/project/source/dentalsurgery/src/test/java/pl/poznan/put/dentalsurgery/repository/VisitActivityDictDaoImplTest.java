package pl.poznan.put.dentalsurgery.repository;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import pl.poznan.put.dentalsurgery.model.VisitActivity;

/**
 * Testy dao do pacjentow
 * 
 * @author Kuciu
 * 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
@Transactional
public class VisitActivityDictDaoImplTest extends
		AbstractTransactionalJUnit4SpringContextTests {
	protected final Log logger = LogFactory.getLog(getClass());
	@Autowired
	private VisitActivityDictDaoImpl visitActivityDictDao;

	/**
	 * Test sprawdzaj¹cy czy nie ma podstawowych b³êdow w mapowaniu hibernate
	 */
	@Test
	public void getAllSuccess() {
		visitActivityDictDao.getAllVisitActivities();
	}

	@Test
	public void addVisitActivitySuccess() {
		final VisitActivity visitActivity = createVisitActivity();

		final long id = visitActivityDictDao.addVisitActivity(visitActivity);
		final VisitActivity visitActivityFromDb = visitActivityDictDao
				.getVisitActivityById(id);
		Assert.assertEquals(visitActivity.getDescription(),
				visitActivityFromDb.getDescription());
		Assert.assertEquals(visitActivity.getPrice(),
				visitActivityFromDb.getPrice(), 0.0);
		Assert.assertEquals(visitActivity.getVat(),
				visitActivityFromDb.getVat(), 0.0);
	}

	@Test
	public void deleteUserSuccess() {
		final VisitActivity visitActivity = createVisitActivity();

		final long id = visitActivityDictDao.addVisitActivity(visitActivity);
		VisitActivity visitActivityFromDb = visitActivityDictDao
				.getVisitActivityById(id);
		visitActivityDictDao.deleteVisitActivity(visitActivityFromDb);
		visitActivityFromDb = visitActivityDictDao.getVisitActivityById(id);
		Assert.assertNull(visitActivityFromDb);
	}

	@Test
	public void updateUserSuccess() {
		VisitActivity visitActivity = createVisitActivity();

		final long id = visitActivityDictDao.addVisitActivity(visitActivity);
		visitActivity = visitActivityDictDao.getVisitActivityById(id);
		visitActivity.setDescription("NewTestDesc");
		visitActivity.setPrice(150.50);
		visitActivity.setVat(0);

		visitActivityDictDao.updateVisitActivity(visitActivity);
		final VisitActivity visitActivityFromDb = visitActivityDictDao
				.getVisitActivityById(id);
		Assert.assertEquals(visitActivity.getDescription(),
				visitActivityFromDb.getDescription());
		Assert.assertEquals(visitActivity.getPrice(),
				visitActivityFromDb.getPrice(), 0.0);
		Assert.assertEquals(visitActivity.getVat(),
				visitActivityFromDb.getVat(), 0.0);

	}

	protected static VisitActivity createVisitActivity() {
		final VisitActivity visitActivity = new VisitActivity();
		visitActivity.setDescription("TestDesc");
		visitActivity.setPrice(100.50);
		visitActivity.setVat(0.23);
		return visitActivity;
	}

}
