package pl.poznan.put.dentalsurgery.model;

public class PhoneNumber {
	private long phoneId;
	private Patient patient;
	private String number;

	public PhoneNumber() {
	}

	public PhoneNumber(final Patient patient) {
		this.patient = patient;
	}

	public long getPhoneId() {
		return phoneId;
	}

	public void setPhoneId(final long phoneId) {
		this.phoneId = phoneId;
	}

	public Patient getPatient() {
		return patient;
	}

	public void setPatient(final Patient patient) {
		this.patient = patient;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(final String number) {
		this.number = number;
	}
}
