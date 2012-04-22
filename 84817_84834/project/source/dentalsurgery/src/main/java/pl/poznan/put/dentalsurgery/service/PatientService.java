package pl.poznan.put.dentalsurgery.service;

import java.util.Collection;

import pl.poznan.put.dentalsurgery.model.Patient;

public interface PatientService {
	Collection<Patient> getAllPatients();

	Collection<Patient> getPatientById(long id);

}
