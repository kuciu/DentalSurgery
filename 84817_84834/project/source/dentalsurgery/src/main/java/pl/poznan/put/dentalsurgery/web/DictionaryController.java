package pl.poznan.put.dentalsurgery.web;

import java.util.Collection;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import pl.poznan.put.dentalsurgery.model.VisitActivity;
import pl.poznan.put.dentalsurgery.service.DictTransferObject;
import pl.poznan.put.dentalsurgery.service.DictionaryService;

@Controller
@RequestMapping({ "/dict" })
public class DictionaryController {

	private static final Log LOG = LogFactory
			.getLog(DictionaryController.class);

	private DictionaryService dictionaryService;

	@Autowired
	public void setDictionaryService(final DictionaryService dictionaryService) {
		this.dictionaryService = dictionaryService;
	}

	/**
	 * Odsyła JSONa, który zawiera wszystkie potrzebne słowniki
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/getall")
	public @ResponseBody
	DictTransferObject getAllDictionaries(final Model model) {
		final DictTransferObject dictionaries = dictionaryService
				.getAllDictionaries();
		return dictionaries;
	}

	@RequestMapping(value = "/visitActivities", method = RequestMethod.GET)
	public String getAllVisitActivities(final Model model) {
		final Collection<VisitActivity> visitActDict = dictionaryService
				.getVisitActivityDict();
		model.addAttribute("visitActDict", visitActDict);
		model.addAttribute("newActivity", new VisitActivity());

		return "visitActDict";
	}

	@RequestMapping(value = "/visitActivities/new", method = RequestMethod.POST)
	public String saveVisitActivity(final VisitActivity activity) {
		dictionaryService.addVisitActivity(activity);
		return "redirect:/dict/visitActivities";
	}

	@RequestMapping(value = "/visitActivities/{activityId}/update", method = RequestMethod.POST)
	public String updateVisitActivity(final VisitActivity activity) {
		dictionaryService.updateVisitActivity(activity);
		return "redirect:/dict/visitActivities";
	}

	@RequestMapping(value = "/visitActivities/{activityId}", method = RequestMethod.GET)
	public @ResponseBody
	VisitActivity getVisitActivity(@PathVariable final Long activityId) {
		return dictionaryService.getVisitActivityById(activityId);
	}

	@RequestMapping(value = "/visitActivities/{activityId}/delete", method = RequestMethod.POST)
	public @ResponseBody
	String deleteVisitActivity(@PathVariable final Long activityId) {
		dictionaryService.deleteVisitActivity(dictionaryService
				.getVisitActivityById(activityId));
		return "OK";
	}
}
