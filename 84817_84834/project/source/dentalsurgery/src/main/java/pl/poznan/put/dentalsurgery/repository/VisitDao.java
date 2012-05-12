package pl.poznan.put.dentalsurgery.repository;

import java.util.Collection;

import pl.poznan.put.dentalsurgery.model.Visit;

public interface VisitDao {

	long addVisit(Visit visit);

	Visit getVisitById(Long visitId);

	void updateVisit(Visit visitFromDb);

	Collection<Visit> getAllVisits();
}
