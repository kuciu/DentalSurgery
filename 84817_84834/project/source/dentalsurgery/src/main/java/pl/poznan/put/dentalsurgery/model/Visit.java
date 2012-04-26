package pl.poznan.put.dentalsurgery.model;

import java.util.Date;
import java.util.Set;

public class Visit {
	private Long visitId;
	private Patient patient;
	private Date visitDate;
	private Set<VisitActivity> activities;
	private String comments;
	private Set<Tooth> teeth;

	public Set<Tooth> getTeeth() {
		return teeth;
	}

	public void setTeeth(final Set<Tooth> teeth) {
		this.teeth = teeth;
	}

	public String getComments() {
		return comments;
	}

	public void setComments(final String comments) {
		this.comments = comments;
	}

	public Patient getPatient() {
		return patient;
	}

	public void setPatient(final Patient patient) {
		this.patient = patient;
	}

	public Visit(final Patient patient) {
		this.patient = patient;
	}

	public Long getVisitId() {
		return visitId;
	}

	public void setVisitId(final Long visitId) {
		this.visitId = visitId;
	}

	public Date getVisitDate() {
		return visitDate;
	}

	public void setVisitDate(final Date visitDate) {
		this.visitDate = visitDate;
	}

	public Set<VisitActivity> getActivities() {
		return activities;
	}

	public void setActivities(final Set<VisitActivity> activities) {
		this.activities = activities;
	}
}
