package pl.poznan.put.dentalsurgery.model;

import java.util.Date;
import java.util.Set;

public class Visit {
	private Long visitId;

	private Date visitDate;
	private Set<VisitActivity> activities;

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
