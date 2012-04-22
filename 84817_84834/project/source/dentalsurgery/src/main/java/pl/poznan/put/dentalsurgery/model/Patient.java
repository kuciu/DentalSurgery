package pl.poznan.put.dentalsurgery.model;

import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

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
	private Set<PhoneNumber> phoneNumbers = new HashSet<PhoneNumber>();
	private Set<Illness> illnesses = new HashSet<Illness>();
	private Set<Medication> medications = new HashSet<Medication>();
	private Set<Visit> visits = new HashSet<Visit>();

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

	public void setVisits(final Set<Visit> visits) {
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

	public Set<PhoneNumber> getPhoneNumbers() {
		return phoneNumbers;
	}

	public void setPhoneNumbers(final Set<PhoneNumber> phoneNumbers) {
		this.phoneNumbers = phoneNumbers;
	}

	public Set<Illness> getIllnesses() {
		return illnesses;
	}

	public void setIllnesses(final Set<Illness> illnesses) {
		this.illnesses = illnesses;
	}

	public Set<Medication> getMedications() {
		return medications;
	}

	public void setMedications(final Set<Medication> medications) {
		this.medications = medications;
	}

}
