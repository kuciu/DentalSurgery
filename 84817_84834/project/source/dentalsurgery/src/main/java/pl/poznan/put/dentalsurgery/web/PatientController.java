package pl.poznan.put.dentalsurgery.web;

import java.util.Collection;
import java.util.Map;

import javax.validation.Valid;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import pl.poznan.put.dentalsurgery.model.Patient;
import pl.poznan.put.dentalsurgery.service.PatientService;

@Controller
public class PatientController {
	private static final Log LOG = LogFactory.getLog(PatientController.class);
	private PatientService patientService;

	@Autowired
	public void setPatientServiceService(final PatientService patientService) {
		this.patientService = patientService;
	}

	@RequestMapping( value="/patients",  method=RequestMethod.GET )
	public String listOfPatientsView(final Map<String, Object> model) {
		
		final Collection<Patient> patientList = patientService.getAllPatients();
		model.put("patientList", patientList);

		return "patients";
	}
	
	/* Dodawanie nowego pacjenta */
	
	@RequestMapping( value = "/patients/new", method=RequestMethod.GET )
	public String newPatientForm (Model model) {
		model.addAttribute("patient", new Patient());
		return "patientForm";
	}
	
	@RequestMapping( value = "/patients/new", method=RequestMethod.POST )
	public String newPatientSubmit (@Valid @ModelAttribute Patient patient, BindingResult result) {
		if (result.hasErrors()) {
			return "patientForm";
		}
		return "redirect:/patients";
	}
	
}
