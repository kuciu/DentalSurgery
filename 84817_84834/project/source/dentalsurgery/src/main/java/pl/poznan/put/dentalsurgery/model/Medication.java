package pl.poznan.put.dentalsurgery.model;

public class Medication {
	private long medicationId;
	private Patient patient;
	private String name;

	public Medication() {
	}

	public Medication(final Patient patient) {
		super();
		this.patient = patient;
	}

	public long getMedicationId() {
		return medicationId;
	}

	public void setMedicationId(final long medicationId) {
		this.medicationId = medicationId;
	}

	public Patient getPatient() {
		return patient;
	}

	public void setPatient(final Patient patient) {
		this.patient = patient;
	}

	public String getName() {
		return name;
	}

	public void setName(final String value) {
		this.name = value;
	}
}
