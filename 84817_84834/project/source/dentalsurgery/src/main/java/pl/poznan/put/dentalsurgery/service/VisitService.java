package pl.poznan.put.dentalsurgery.service;

import pl.poznan.put.dentalsurgery.model.Visit;

public interface VisitService {

	Visit getVisidById(Long visitId);

	long addVisit(Visit visit);
	
	/*
	Collection<Patient> getAllPatients();

	void deletePatient(Patient patient);

	void updatePatient(Patient patient);
	*/
}
