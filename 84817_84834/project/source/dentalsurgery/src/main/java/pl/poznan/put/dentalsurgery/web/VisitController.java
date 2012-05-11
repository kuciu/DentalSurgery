package pl.poznan.put.dentalsurgery.web;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import pl.poznan.put.dentalsurgery.model.Patient;
import pl.poznan.put.dentalsurgery.service.PatientService;

@Controller
@RequestMapping("/patients/{patientId}/visits")
public class VisitController {

	private static final Log LOG = LogFactory.getLog(PatientController.class);
	private PatientService patientService;
	
	@Autowired
	public void setPatientServiceService(final PatientService patientService) {
		this.patientService = patientService;
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
	@RequestMapping(value="/add")
	public String addVisitController(@PathVariable Long patientId, Model model) {
		Patient patient = patientService.getPatientById(patientId);
		if (patient == null) {
			model.addAttribute("message", "Nie ma pacjenta o identyfikatorze " + patientId);
			return "error";
		}
		model.addAttribute(patient);
		return "add-visit";
	}
	
}
