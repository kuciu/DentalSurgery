package pl.poznan.put.dentalsurgery.model;

public class ToothActivity {
	private Long activityId;
	private String description;
	private Double price;
	private Double vat;
	private Boolean allTooth;

	public ToothActivity() {
	}

	public Long getActivityId() {
		return activityId;
	}

	public void setActivityId(final Long toothActivityId) {
		this.activityId = toothActivityId;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(final String description) {
		this.description = description;
	}

	public Double getPrice() {
		return price;
	}

	public void setPrice(final Double price) {
		this.price = price;
	}

	public Double getVat() {
		return vat;
	}

	public void setVat(final Double vat) {
		this.vat = vat;
	}

	public Boolean isAllTooth() {
		return allTooth;
	}

	public void setAllTooth(final Boolean allTooth) {
		this.allTooth = allTooth;
	}
}
