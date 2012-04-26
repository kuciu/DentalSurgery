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

import pl.poznan.put.dentalsurgery.model.ToothActivity;

/**
 * Testy dao do pacjentow
 * 
 * @author Kuciu
 * 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
@Transactional
public class ToothActivityDictDaoImplTest extends
		AbstractTransactionalJUnit4SpringContextTests {
	protected final Log logger = LogFactory.getLog(getClass());
	@Autowired
	private ToothActivityDictDaoImpl toothActivityDictDao;

	/**
	 * Test sprawdzaj¹cy czy nie ma podstawowych b³êdow w mapowaniu hibernate
	 */
	@Test
	public void getAllSuccess() {
		toothActivityDictDao.getAllToothActivities();
	}

	@Test
	public void addToothActivitySuccess() {
		final ToothActivity toothActivity = createToothActivity();

		final long id = toothActivityDictDao.addToothActivity(toothActivity);
		final ToothActivity toothActivityFromDb = toothActivityDictDao
				.getToothActivityById(id);
		Assert.assertEquals(toothActivity.getDescription(),
				toothActivityFromDb.getDescription());
		Assert.assertEquals(toothActivity.getPrice(),
				toothActivityFromDb.getPrice(), 0.0);
		Assert.assertEquals(toothActivity.getVat(),
				toothActivityFromDb.getVat(), 0.0);
	}

	@Test
	public void deleteToothActivitySuccess() {
		final ToothActivity toothActivity = createToothActivity();

		final long id = toothActivityDictDao.addToothActivity(toothActivity);
		ToothActivity toothActivityFromDb = toothActivityDictDao
				.getToothActivityById(id);
		toothActivityDictDao.deleteToothActivity(toothActivityFromDb);
		toothActivityFromDb = toothActivityDictDao.getToothActivityById(id);
		Assert.assertNull(toothActivityFromDb);
	}

	@Test
	public void updateToothActivitySuccess() {
		ToothActivity toothActivity = createToothActivity();

		final long id = toothActivityDictDao.addToothActivity(toothActivity);
		toothActivity = toothActivityDictDao.getToothActivityById(id);
		toothActivity.setDescription("NewTestDesc");
		toothActivity.setPrice(150.50);
		toothActivity.setVat(0);
		toothActivity.setAllTooth(false);

		toothActivityDictDao.updateToothActivity(toothActivity);
		final ToothActivity toothActivityFromDb = toothActivityDictDao
				.getToothActivityById(id);
		Assert.assertEquals(toothActivity.getDescription(),
				toothActivityFromDb.getDescription());
		Assert.assertEquals(toothActivity.getPrice(),
				toothActivityFromDb.getPrice(), 0.0);
		Assert.assertEquals(toothActivity.getVat(),
				toothActivityFromDb.getVat(), 0.0);

	}

	protected static ToothActivity createToothActivity() {
		final ToothActivity toothActivity = new ToothActivity();
		toothActivity.setDescription("TestDesc");
		toothActivity.setPrice(100.50);
		toothActivity.setVat(0.23);
		toothActivity.setAllTooth(true);
		return toothActivity;
	}

}
