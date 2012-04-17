package pl.poznan.put.dentalsurgery.model;

import java.util.Date;

public class SimpleEntity {

	private Long id;
	private String someText;
	private Date someDate;
	private Integer someNumber;

	public Long getId() {
		return id;
	}

	@SuppressWarnings("unused")
	private void setId(Long id) {
		this.id = id;
	}

	public String getSomeText() {
		return someText;
	}

	public void setSomeText(String someText) {
		this.someText = someText;
	}

	public Date getSomeDate() {
		return someDate;
	}

	public void setSomeDate(Date someDate) {
		this.someDate = someDate;
	}

	public Integer getSomeNumber() {
		return someNumber;
	}

	public void setSomeNumber(Integer someNumber) {
		this.someNumber = someNumber;
	}

}
