package pl.poznan.put.dentalsurgery.repository;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import pl.poznan.put.dentalsurgery.model.Patient;
import pl.poznan.put.dentalsurgery.model.Tooth;
import pl.poznan.put.dentalsurgery.model.ToothActivity;
import pl.poznan.put.dentalsurgery.model.ToothState;
import pl.poznan.put.dentalsurgery.model.Visit;

/**
 * Testy dao do pacjentow
 * 
 * @author Kuciu
 * 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
@Transactional
public class TeethDaoImplTest extends
		AbstractTransactionalJUnit4SpringContextTests {
	protected final Log logger = LogFactory.getLog(getClass());
	@Autowired
	private TeethDaoImpl teethDao;

	@Autowired
	private ToothStateDictDaoImpl toothStateDictDao;

	@Autowired
	private ToothActivityDictDaoImpl toothActivityDictDao;

	@Autowired
	private PatientDaoImpl patientDao;

	private Patient patient;
	private Visit visit;

	@Before
	public void prepare() {
		this.patient = PatientDaoImplTest.createPatient();
		visit = new Visit(patient);
		patient.getVisits().add(visit);
		patientDao.addPatient(patient);
	}

	/**
	 * Test sprawdzajacy czy nie ma podstawowych bledow w mapowaniu hibernate
	 */
	@Test
	public void getAllSuccess() {
		teethDao.getAllTeeth();
	}

	@Test
	public void addToothStateSuccess() {

		final Tooth tooth = new Tooth(visit);
		final ToothState toothState = ToothStateDictDaoImplTest
				.createToothState();
		toothStateDictDao.addToothState(toothState);

		final ToothActivity toothActivity = ToothActivityDictDaoImplTest
				.createToothActivity();
		toothActivityDictDao.addToothActivity(toothActivity);

		final Set<ToothActivity> toothActivities = new HashSet<ToothActivity>();
		toothActivities.add(toothActivity);

		tooth.setNumber(22);

		tooth.setActivities(toothActivities);

		tooth.setAllToothState(toothState);
		tooth.setArea1State(toothState);
		tooth.setArea2State(toothState);
		tooth.setArea3State(toothState);
		tooth.setArea4State(toothState);
		tooth.setArea5State(toothState);
		tooth.setArea6State(toothState);
		tooth.setArea7State(toothState);
		tooth.setArea8State(toothState);

		final long toothId = teethDao.addTooth(tooth);

		final Tooth toothFromDb = teethDao.getToothById(toothId);

		Assert.assertEquals(tooth.getActivities().size(), toothFromDb
				.getActivities().size());
		Assert.assertEquals(tooth.getAllToothState(),
				toothFromDb.getAllToothState());
		Assert.assertEquals(tooth.getArea1State(), toothFromDb.getArea1State());
		Assert.assertEquals(tooth.getArea2State(), toothFromDb.getArea2State());
		Assert.assertEquals(tooth.getArea3State(), toothFromDb.getArea3State());
		Assert.assertEquals(tooth.getArea4State(), toothFromDb.getArea4State());
		Assert.assertEquals(tooth.getArea4State(), toothFromDb.getArea4State());
		Assert.assertEquals(tooth.getArea5State(), toothFromDb.getArea5State());
		Assert.assertEquals(tooth.getArea6State(), toothFromDb.getArea6State());
		Assert.assertEquals(tooth.getArea7State(), toothFromDb.getArea7State());
		Assert.assertEquals(tooth.getArea7State(), toothFromDb.getArea7State());

	}

	@Test
	public void deleteUserSuccess() {
		final Tooth tooth = new Tooth(visit);
		final ToothState toothState = ToothStateDictDaoImplTest
				.createToothState();
		toothStateDictDao.addToothState(toothState);

		final ToothActivity toothActivity = ToothActivityDictDaoImplTest
				.createToothActivity();
		toothActivityDictDao.addToothActivity(toothActivity);

		final Set<ToothActivity> toothActivities = new HashSet<ToothActivity>();
		toothActivities.add(toothActivity);

		tooth.setNumber(22);

		tooth.setActivities(toothActivities);

		tooth.setAllToothState(toothState);
		tooth.setArea1State(toothState);
		tooth.setArea2State(toothState);
		tooth.setArea3State(toothState);
		tooth.setArea4State(toothState);
		tooth.setArea5State(toothState);
		tooth.setArea6State(toothState);
		tooth.setArea7State(toothState);
		tooth.setArea8State(toothState);

		final long toothId = teethDao.addTooth(tooth);

		final Tooth toothFromDb = teethDao.getToothById(toothId);

		teethDao.deleteTooth(toothFromDb);

		Assert.assertNull(teethDao.getToothById(toothId));
	}

	@Test
	public void updateUserSuccess() {
		// ToothState toothState = new ToothState();
		// toothState.setDescription("TestDesc");
		// toothState.setAllTooth(false);
		//
		// final long id = teethDao.addToothState(toothState);
		// toothState = teethDao.getToothStateById(id);
		//
		// toothState.setAllTooth(true);
		// toothState.setDescription("NewTestDesc");
		//
		// teethDao.updateToothState(toothState);
		//
		// final ToothState toothStateFromDb = teethDao.getToothStateById(id);
		//
		// Assert.assertEquals(toothState.getDescription(),
		// toothStateFromDb.getDescription());
		// Assert.assertEquals(toothState.isAllTooth(),
		// toothStateFromDb.isAllTooth());

	}

	@Test
	public void getTeethByVisitSuccess() {
		final Tooth tooth = new Tooth(visit);
		Set<Tooth> teeth = new HashSet<Tooth>();
		teeth.add(tooth);
		visit.setTeeth(teeth);
		final ToothState toothState = ToothStateDictDaoImplTest
				.createToothState();
		toothStateDictDao.addToothState(toothState);
		teethDao.addTooth(tooth);
		patientDao.updateUser(patient);
		teeth = visit.getTeeth();
		final List<Tooth> teethFromDb = teethDao.getTeethByVisit(visit);
		Assert.assertEquals(teeth.size(), teethFromDb.size());
		for (final Tooth tooth1 : teeth) {
			Assert.assertTrue(teethFromDb.contains(tooth1));
		}
		for (final Tooth tooth1 : teethFromDb) {
			Assert.assertTrue(teeth.contains(tooth1));
		}
	}
}
