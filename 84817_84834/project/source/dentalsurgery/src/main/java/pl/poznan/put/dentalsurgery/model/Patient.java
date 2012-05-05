package pl.poznan.put.dentalsurgery.model;

import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.util.AutoPopulatingList;

/**
 * 
 * @author Kuciu
 * 
 */
public class Patient {
	private Long patientId;

	@NotBlank
	private String name;

	@NotBlank
	private String surname;

	@NotNull
	@DateTimeFormat(pattern = "dd-MM-yyyy")
	@Past
	private Date bornDate;

	@NotBlank
	private String city;

	@NotBlank
	private String street;

	private List<PhoneNumber> phoneNumbers = new AutoPopulatingList<PhoneNumber>(
			PhoneNumber.class);
	private Set<Illness> illnesses = new HashSet<Illness>();
	private Set<Medication> medications = new HashSet<Medication>();
	private Set<Visit> visits = new HashSet<Visit>();

	public Patient() {
	}

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

	public List<PhoneNumber> getPhoneNumbers() {
		return phoneNumbers;
	}

	public void setPhoneNumbers(final List<PhoneNumber> phoneNumbers) {
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
