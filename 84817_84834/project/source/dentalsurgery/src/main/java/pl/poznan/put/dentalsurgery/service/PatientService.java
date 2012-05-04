package pl.poznan.put.dentalsurgery.service;

import java.util.Collection;

import pl.poznan.put.dentalsurgery.model.Patient;

public interface PatientService {
	Collection<Patient> getAllPatients();

	Patient getPatientById(long id);

	long addPatient(Patient patient);

	void deletePatient(Patient patient);
	
}
