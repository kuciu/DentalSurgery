package pl.poznan.put.dentalsurgery.model;

public class Illness {
	private long illnessId;
	private Patient patient;
	private String name;

	public Illness() {
	}

	public Illness(final Patient patient) {
		this.patient = patient;
	}

	public long getIllnessId() {
		return illnessId;
	}

	public void setIllnessId(final long illnessId) {
		this.illnessId = illnessId;
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
