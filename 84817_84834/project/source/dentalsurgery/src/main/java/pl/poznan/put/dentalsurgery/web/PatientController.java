package pl.poznan.put.dentalsurgery.web;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import pl.poznan.put.dentalsurgery.model.Illness;
import pl.poznan.put.dentalsurgery.model.Medication;
import pl.poznan.put.dentalsurgery.model.Patient;
import pl.poznan.put.dentalsurgery.model.PhoneNumber;
import pl.poznan.put.dentalsurgery.service.PatientService;

@Controller
public class PatientController {
	private static final Log LOGER = LogFactory.getLog(PatientController.class);
	private PatientService patientService;

	@Autowired
	public void setPatientServiceService(final PatientService patientService) {
		this.patientService = patientService;
	}

	@RequestMapping(value = "/patients", method = RequestMethod.GET)
	public String listOfPatientsView(final Map<String, Object> model) {

		final Collection<Patient> patientList = patientService.getAllPatients();
		model.put("patientList", patientList);

		return "patients";
	}

	/* Dodawanie nowego pacjenta */

	@RequestMapping(value = "/patients/new", method = RequestMethod.GET)
	public String newPatientForm(final Model model) {
		model.addAttribute("patient", new Patient());
		return "patientForm";
	}

	@RequestMapping(value = "/patients/new", method = RequestMethod.POST)
	public String newPatientSubmit(
			@Valid @ModelAttribute final Patient patient,
			final BindingResult result, final HttpServletRequest request,
			final HttpServletResponse response) {
		// SPAW Ni jak nie mogłem rozkminić jak w formularzu JSP, gdzie dane są
		// tylko stringami można utworzyć listę obiektów. Alternatywną pewnie by
		// było puszczanie wszystkiego JSONem.
		// Analogicznie będą robione pozostałe listy :(
		// Specjalnie przed zwroceniem błędów, można będzie iterować i wypełnić
		// ponownie pola!
		final String[] phones = request.getParameterValues("phones");
		final List<PhoneNumber> phoneNumbers = new ArrayList<PhoneNumber>();
		if (phones != null) {
			for (final String phone : phones) {
				phoneNumbers.add(new PhoneNumber(patient, phone));
			}
		}
		patient.setPhoneNumbers(phoneNumbers);

		final String[] illnessTab = request.getParameterValues("illness");
		final List<Illness> illnesses = new ArrayList<Illness>();
		if (illnessTab != null) {
			for (final String illness : illnessTab) {
				illnesses.add(new Illness(patient, illness));
			}
		}
		patient.setIllnesses(illnesses);

		final String[] medicationsTab = request
				.getParameterValues("medications");
		final List<Medication> medications = new ArrayList<Medication>();
		if (medicationsTab != null) {
			for (final String medication : medicationsTab) {
				medications.add(new Medication(patient, medication));
			}
		}
		patient.setMedications(medications);

		if (result.hasErrors()) {
			// jeśli są błędy w formularzu - wyświetlamy go ponownie
			return "patientForm";
		}

		// nie ma błędów, dodajemy pacjenta
		patientService.addPatient(patient);
		// przekierowanie na listę pacjentów
		return "redirect:/patients";
	}

	/**
	 * Usunięcie pacjenta o podanym identyfikatorze
	 * 
	 * @param patientId
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/patients/{patientId}/delete", method = RequestMethod.POST)
	public @ResponseBody
	String deletePatient(@PathVariable final Long patientId,
			final HttpServletResponse response) {
		final Patient patient = patientService.getPatientById(patientId);
		if (patient != null) {
			patientService.deletePatient(patient);
			return "OK";
		} else {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return "ERROR";
		}
	}

	/**
	 * Usunięcie pacjenta o podanym identyfikatorze
	 * 
	 * @param patientId
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/patients/{patientId}/edit", method = RequestMethod.GET)
	public String editPatient(@PathVariable final Long patientId,
			final Model model, final HttpServletResponse response) {
		final Patient patient = patientService.getPatientById(patientId);
		if (patient != null) {
			/**
			 * Czyszczenie listy z nulli - przyleglość hibernate z
			 * wykorzystaniem list!
			 */
			patient.getPhoneNumbers().removeAll(Collections.singleton(null));
			patient.getIllnesses().removeAll(Collections.singleton(null));
			patient.getMedications().removeAll(Collections.singleton(null));

			model.addAttribute("patient", patient);
			return "patientForm";
		} else {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			return "redirect:/patients";
		}
	}
}
