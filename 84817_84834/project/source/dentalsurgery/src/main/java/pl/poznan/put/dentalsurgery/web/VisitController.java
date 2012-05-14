package pl.poznan.put.dentalsurgery.web;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
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
	 * Dodaje do modelu pacjenta o ID podanym w URLu
	 * @param patientId
	 * @return
	 */
	@ModelAttribute
	public Patient getPatient(@PathVariable Long patientId) {
		return patientService.getPatientById(patientId);
	}
	
	/**
	 * Wyświetla stronę JSP z listą wizyt pacjenta, 
	 * Na stronie tej można zobaczyć listę dotychczasowych wizyt pacjenta.
	 * 
	 * @return
	 */
	@RequestMapping({"", "/"})
	public String visitsListView(@ModelAttribute Patient patient, Model model) {
		if (patient == null) {
			model.addAttribute("message", "Nie ma takiego pacjenta");
			return "error";
		}
		return "visits";
	}
	
	/**
	 * Wyświetla stronę JSP na której można dodać nową wizytę
	 * @param patientId
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String addVisitController(@ModelAttribute Patient patient, Model model) {
		if (patient == null) {
			model.addAttribute("message", "Nie ma takiego pacjenta");
			return "error";
		}
		return "add-visit";
	}
	
	/**
	 * Zapisuje do bazy obiekt wizyty, wysłany POSTem w postaci jsona
	 * @param visit
	 * @param patient
	 * @return
	 */
	@RequestMapping(value="/save", method=RequestMethod.POST, consumes="application/json")
	public @ResponseBody Visit saveVisit(@RequestBody Visit visit, @ModelAttribute Patient patient) {
		visit.setPatient(patient);
		Long visitId = visitService.saveDeserializedVisit(visit);
		visitService.getVisidById(visitId);
		return visit;
	}
	
	/**
	 * Zwraca obiekt w postaci JSON konkretnej wizyty istniejącej w bazie danych
	 * @param visitId
	 * @return
	 */
	@RequestMapping(value="/{visitId}")
	public @ResponseBody Visit getVisit(@PathVariable Long visitId, @ModelAttribute Patient patient) {
		Visit visit = visitService.getVisidById(visitId);
		// TODO sprawdzić, czy wizyta należy do pacjenta!
		return visit;
	}
	
	/**
	 * Zwraca JSONa z obiektem nowej wizyty. Obiekt ten tworzony jest w oparciu o ostatnia wizytę. 
	 * Jeśli jest to pierwsza wizyta, tworzone są obiekty wszystkich zębów w notacji FDI.
	 * 
	 * @param patientId
	 * @return
	 */
	@RequestMapping(value="/prepareNew", produces="application/json")
	public @ResponseBody Visit prepareNewVisit(@ModelAttribute Patient patient) {
		return visitService.prepareNewVisit(patient);
	}
	
	/**
	 * Usuwa wizytę z bazy
	 * @param visitId
	 * @return
	 */
	@RequestMapping(value="/{visitId}/delete", method=RequestMethod.GET)
	public String deleteVisit(@PathVariable Long visitId, @ModelAttribute Patient patient, Model model) {
		Visit visit = visitService.getVisidById(visitId);
		if (visit == null) {
			model.addAttribute("message", "Nie ma takiej wizyty.");
			return "error";
		}
		if (visit.getPatient() == null
				|| !patient.getPatientId().equals(
						visit.getPatient().getPatientId())) {
			model.addAttribute("message", "Wizyta nie należy do podanego pacjenta.");
			return "error";
		}
		visitService.removeVisit(visit);
		model.addAttribute("message", "Wizyta została usunięta.");
		return "alert";
	}

}
