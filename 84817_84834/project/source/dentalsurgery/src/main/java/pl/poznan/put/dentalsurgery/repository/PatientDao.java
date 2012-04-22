package pl.poznan.put.dentalsurgery.repository;

import java.util.Collection;

import pl.poznan.put.dentalsurgery.model.Patient;

public interface PatientDao {
	Collection<Patient> loadAllPatients();

	void deletePatient(Patient patient);

	long addPatient(Patient patient);

	Patient getPatientById(Long id);

	void updateUser(Patient patientFromDb);
}
