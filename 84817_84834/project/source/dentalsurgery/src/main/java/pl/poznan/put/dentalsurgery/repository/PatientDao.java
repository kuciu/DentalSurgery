package pl.poznan.put.dentalsurgery.repository;

import java.util.Collection;

import pl.poznan.put.dentalsurgery.model.Patient;

public interface PatientDao {
	Collection<Patient> loadAllPatients();
}
