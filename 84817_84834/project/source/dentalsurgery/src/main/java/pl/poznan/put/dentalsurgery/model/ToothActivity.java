package pl.poznan.put.dentalsurgery.model;

public class ToothActivity {
	private long activityId;
	private String description;
	private double price;
	private double vat;
	private boolean allTooth;

	public ToothActivity() {
	}

	public long getActivityId() {
		return activityId;
	}

	public void setActivityId(final long toothActivityId) {
		this.activityId = toothActivityId;
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

	public boolean isAllTooth() {
		return allTooth;
	}

	public void setAllTooth(final boolean allTooth) {
		this.allTooth = allTooth;
	}
}
