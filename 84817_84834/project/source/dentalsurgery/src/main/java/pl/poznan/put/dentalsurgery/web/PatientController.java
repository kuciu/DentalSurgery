package pl.poznan.put.dentalsurgery.web;

import java.util.Collection;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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

	@RequestMapping({ "/patients" })
	public String showSomePage(final Map<String, Object> model) {
		LOG.info("Pobieranie pacjentow - START");
		final Collection<Patient> patientList = patientService.getAllPatients();
		model.put("patientList", patientList);

		return "patients";
	}
}
