package pl.poznan.put.dentalsurgery.repository;

import junit.framework.Assert;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import pl.poznan.put.dentalsurgery.model.ToothState;

/**
 * Testy dao do pacjentow
 * 
 * @author Kuciu
 * 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
@Transactional
public class ToothStateDictDaoImplTest extends
		AbstractTransactionalJUnit4SpringContextTests {
	protected final Log logger = LogFactory.getLog(getClass());
	@Autowired
	private ToothStateDictDaoImpl toothStateDictDao;

	/**
	 * Test sprawdzaj¹cy czy nie ma podstawowych b³êdow w mapowaniu hibernate
	 */
	@Test
	public void getAllSuccess() {
		toothStateDictDao.getAllToothStates();
	}

	@Test
	public void addToothStateSuccess() {
		final ToothState toothState = createToothState();

		final long id = toothStateDictDao.addToothState(toothState);
		final ToothState toothStateFromDb = toothStateDictDao
				.getToothStateById(id);

		Assert.assertEquals(toothState.getDescription(),
				toothStateFromDb.getDescription());
		Assert.assertEquals(toothState.isAllTooth(),
				toothStateFromDb.isAllTooth());
	}

	@Test
	public void deleteUserSuccess() {
		final ToothState toothState = createToothState();

		final long id = toothStateDictDao.addToothState(toothState);
		final ToothState toothStateFromDb = toothStateDictDao
				.getToothStateById(id);
		toothStateDictDao.deleteToothState(toothStateFromDb);
		Assert.assertNull(toothStateDictDao.getToothStateById(id));
	}

	@Test
	public void updateUserSuccess() {
		ToothState toothState = createToothState();

		final long id = toothStateDictDao.addToothState(toothState);
		toothState = toothStateDictDao.getToothStateById(id);

		toothState.setAllTooth(true);
		toothState.setDescription("NewTestDesc");

		toothStateDictDao.updateToothState(toothState);

		final ToothState toothStateFromDb = toothStateDictDao
				.getToothStateById(id);

		Assert.assertEquals(toothState.getDescription(),
				toothStateFromDb.getDescription());
		Assert.assertEquals(toothState.isAllTooth(),
				toothStateFromDb.isAllTooth());

	}

	protected static ToothState createToothState() {
		final ToothState toothState = new ToothState();
		toothState.setDescription("TestDesc");
		toothState.setAllTooth(false);
		return toothState;
	}
}
