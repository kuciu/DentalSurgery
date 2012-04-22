package pl.poznan.put.dentalsurgery.model;

import java.util.Collection;
import java.util.Date;
import java.util.List;

/**
 * 
 * @author Kuciu
 * 
 */
public class Patient {
	private Long patientId;
	private String name;
	private String surname;
	private Date bornDate;
	private String city;
	private String street;
	private List<PhoneNumber> phoneNumbers;
	private List<String> medicalHistory;
	private List<String> medications;
	private List<Visit> visits;

	public Long getPatientId() {
		return patientId;
	}

	public void setPatientId(final Long patientId) {
		this.patientId = patientId;
	}

	public Date getBornDate() {
		return bornDate;
	}

	public void setBornDate(final Date bornDate) {
		this.bornDate = bornDate;
	}

	public Collection<Visit> getVisits() {
		return visits;
	}

	public void setVisits(final List<Visit> visits) {
		this.visits = visits;
	}

	public String getName() {
		return name;
	}

	public void setName(final String name) {
		this.name = name;
	}

	public String getSurname() {
		return surname;
	}

	public void setSurname(final String surname) {
		this.surname = surname;
	}

	public String getCity() {
		return city;
	}

	public void setCity(final String city) {
		this.city = city;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(final String street) {
		this.street = street;
	}

	public List<PhoneNumber> getPhoneNumbers() {
		return phoneNumbers;
	}

	public void setPhoneNumbers(final List<PhoneNumber> phoneNumbers) {
		this.phoneNumbers = phoneNumbers;
	}

	public List<String> getMedicalHistory() {
		return medicalHistory;
	}

	public void setMedicalHistory(final List<String> medicalHistory) {
		this.medicalHistory = medicalHistory;
	}

	public List<String> getMedications() {
		return medications;
	}

	public void setMedications(final List<String> medications) {
		this.medications = medications;
	}

}
