package pl.poznan.put.dentalsurgery.repository;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

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

import pl.poznan.put.dentalsurgery.model.Illness;
import pl.poznan.put.dentalsurgery.model.Medication;
import pl.poznan.put.dentalsurgery.model.Patient;
import pl.poznan.put.dentalsurgery.model.PhoneNumber;

/**
 * Testy dao do pacjentow
 * 
 * @author Kuciu
 * 
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
@Transactional
public class PatientDaoImplTest extends
		AbstractTransactionalJUnit4SpringContextTests {
	protected final Log logger = LogFactory.getLog(getClass());
	@Autowired
	private PatientDaoImpl patientDao;

	@Test
	public void addUserSuccess() {
		final Patient patient = createPatient();

		final long id = patientDao.addPatient(patient);
		final Patient patientFromDb = patientDao.getPatientById(id);

		Assert.assertEquals(patient.getName(), patientFromDb.getName());
		Assert.assertEquals(patient.getSurname(), patientFromDb.getSurname());
		Assert.assertEquals(patient.getCity(), patient.getCity());
		Assert.assertEquals(patient.getStreet(), patient.getStreet());
		Assert.assertEquals(patient.getBornDate(), patientFromDb.getBornDate());
		Assert.assertEquals(patient.getPhoneNumbers().size(), patientFromDb
				.getPhoneNumbers().size());
		Assert.assertEquals(patient.getMedications().size(), patientFromDb
				.getMedications().size());
		Assert.assertEquals(patient.getIllnesses().size(), patientFromDb
				.getIllnesses().size());
		Assert.assertEquals(patient.getVisits().size(), patientFromDb
				.getVisits().size());
	}

	@Test
	public void deleteUserSuccess() {
		final Patient patient = createPatient();

		final long id = patientDao.addPatient(patient);
		final Patient patientFromDb = patientDao.getPatientById(id);
		patientDao.deletePatient(patientFromDb);
		Assert.assertNull(patientDao.getPatientById(id));
	}

	@Test
	public void updateUserSuccess() {
		Patient patient = createPatient();
		final long id = patientDao.addPatient(patient);
		patient = patientDao.getPatientById(id);
		patient.getPhoneNumbers().clear();
		patient.setName("NewName");
		patientDao.updateUser(patient);
		final Patient patientFromDb = patientDao.getPatientById(id);

		Assert.assertEquals(patient.getName(), patientFromDb.getName());
		Assert.assertEquals(patient.getSurname(), patientFromDb.getSurname());
		Assert.assertEquals(patient.getCity(), patient.getCity());
		Assert.assertEquals(patient.getStreet(), patient.getStreet());
		Assert.assertEquals(patient.getBornDate(), patientFromDb.getBornDate());
		Assert.assertEquals(patient.getPhoneNumbers().size(), patientFromDb
				.getPhoneNumbers().size());
		Assert.assertEquals(patient.getMedications().size(), patientFromDb
				.getMedications().size());
		Assert.assertEquals(patient.getIllnesses().size(), patientFromDb
				.getIllnesses().size());
		Assert.assertEquals(patient.getVisits().size(), patientFromDb
				.getVisits().size());

	}

	private Patient createPatient() {
		// TODO Zmienic na builder
		final Patient patient = new Patient();
		patient.setName("TestName");
		patient.setSurname("TestSurname");
		patient.setCity("TestCity");
		patient.setStreet("TestStreet");
		patient.setBornDate(new Date());

		final PhoneNumber phoneNumber1 = new PhoneNumber(patient);
		phoneNumber1.setNumber("1234567890");
		final PhoneNumber phoneNumber2 = new PhoneNumber(patient);
		phoneNumber2.setNumber("0987654321");

		final Illness illness = new Illness(patient);
		illness.setName("AAAA");
		final Set<Illness> illnesses = new HashSet<Illness>();
		illnesses.add(illness);
		patient.setIllnesses(illnesses);

		final Medication medication = new Medication(patient);
		medication.setName("AAAA");
		final Set<Medication> medications = new HashSet<Medication>();
		medications.add(medication);
		patient.setMedications(medications);

		final Set<PhoneNumber> phoneNumbers = new HashSet<PhoneNumber>();
		phoneNumbers.add(phoneNumber1);
		phoneNumbers.add(phoneNumber2);
		patient.setPhoneNumbers(phoneNumbers);
		return patient;
	}
}
