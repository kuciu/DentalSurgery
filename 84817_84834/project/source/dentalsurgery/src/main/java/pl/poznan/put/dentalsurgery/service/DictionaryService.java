package pl.poznan.put.dentalsurgery.service;

import java.util.Collection;

import pl.poznan.put.dentalsurgery.model.VisitActivity;

public interface DictionaryService {

	DictTransferObject getAllDictionaries();

	Collection<VisitActivity> getVisitActivityDict();

	void addVisitActivity(VisitActivity activity);

	VisitActivity getVisitActivityById(Long activityId);

	void updateVisitActivity(VisitActivity activity);

	void deleteVisitActivity(VisitActivity visitActivityById);

}
