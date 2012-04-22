package pl.poznan.put.dentalsurgery.model;

public class VisitActivity {
	private long activityId;
	private String description;
	private double price;
	private double vat;

	public long getActivityId() {
		return activityId;
	}

	public void setActivityId(final long activityId) {
		this.activityId = activityId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(final String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(final double price) {
		this.price = price;
	}

	public double getVat() {
		return vat;
	}

	public void setVat(final double vat) {
		this.vat = vat;
	}
}
