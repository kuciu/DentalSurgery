package pl.poznan.put.dentalsurgery.web;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import pl.poznan.put.dentalsurgery.model.Patient;
import pl.poznan.put.dentalsurgery.model.Visit;
import pl.poznan.put.dentalsurgery.service.PatientService;
import pl.poznan.put.dentalsurgery.service.VisitService;

@Controller
@RequestMapping("/patients/{patientId}/visits")
public class VisitController {

	private static final Log LOG = LogFactory.getLog(VisitController.class);
	private PatientService patientService;
	private VisitService visitService;
	
	@Autowired
	public void setPatientServiceService(final PatientService patientService) {
		this.patientService = patientService;
	}
	
	@Autowired
	public void setVisitService(VisitService visitService) {
		this.visitService = visitService;
	}
	
	/**
	 * Wyświetla stronę JSP z listą wizyt pacjenta, 
	 * Na stronie tej można zobaczyć listę dotychczasowych wizyt pacjenta
	 * 
	 * @return
	 */
	@RequestMapping({"", "/"})
	public String listVisitsController(@PathVariable Long patientId) {
		return "visits";
	}
	
	/**
	 * Wyświetla stronę JSP na której można dodać nową wizytę
	 * 
	 * @return
	 */
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String addVisitController(@PathVariable Long patientId, Model model) {
		Patient patient = patientService.getPatientById(patientId);
		if (patient == null) {
			model.addAttribute("message", "Nie ma pacjenta o identyfikatorze " + patientId);
			return "error";
		}
		model.addAttribute(patient);
		return "add-visit";
	}
	
	/**
	 * Zapisuje do bazy obiekt wizyty, wysłany POSTem w postaci jsona
	 */
	@RequestMapping(value="/save", method=RequestMethod.POST, consumes="application/json")
	public @ResponseBody String saveVisit(@RequestBody Visit visit) {
		
		return "tu coś będzie";
	}
	
	
	/**
	 * Zwraca obiekt JSON konkretnej wizyty istniejącej w bazie danych
	 * @param patientId
	 * @param visitId
	 * @return
	 */
	@RequestMapping(value="/{visitId}")
	public @ResponseBody Visit getVisit(@PathVariable Long patientId, @PathVariable Long visitId) {
		
		return visitService.getVisidById(visitId);
		
	}
	
	
	
	/**
	 * Zwraca JSONa z obiektem nowej wizyty. Obiekt ten tworzony jest w oparciu o wcześniejsze wizyty, 
	 * po to aby przenieść poprzednio ustalone stany zębów 
	 * 
	 * @param patientId
	 * @return
	 */
	@RequestMapping(value="/newVisit", produces="application/json")
	public @ResponseBody Visit getNewVisitObject(@PathVariable Long patientId) {
		
		
		
		return null;
		
	}



}
