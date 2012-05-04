package pl.poznan.put.dentalsurgery.model;

import java.util.Set;

public class Tooth {
	private long toothId;
	private int number;

	private Visit visit;

	private Set<ToothActivity> activities;

	private ToothState allToothState;

	private ToothState area1State;
	private ToothState area2State;
	private ToothState area3State;
	private ToothState area4State;
	private ToothState area5State;

	private ToothState area6State;

	private ToothState area7State;

	private ToothState area8State;

	public Tooth() {
	}

	public Tooth(final Visit visit) {
		this.visit = visit;
	}

	public long getToothId() {
		return toothId;
	}

	public void setToothId(final long toothId) {
		this.toothId = toothId;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(final int number) {
		this.number = number;
	}

	public ToothState getAllToothState() {
		return allToothState;
	}

	public void setAllToothState(final ToothState allToothState) {
		this.allToothState = allToothState;
	}

	public ToothState getArea1State() {
		return area1State;
	}

	public void setArea1State(final ToothState area1State) {
		this.area1State = area1State;
	}

	public ToothState getArea2State() {
		return area2State;
	}

	public void setArea2State(final ToothState area2State) {
		this.area2State = area2State;
	}

	public ToothState getArea3State() {
		return area3State;
	}

	public void setArea3State(final ToothState area3State) {
		this.area3State = area3State;
	}

	public ToothState getArea4State() {
		return area4State;
	}

	public void setArea4State(final ToothState area4State) {
		this.area4State = area4State;
	}

	public ToothState getArea5State() {
		return area5State;
	}

	public void setArea5State(final ToothState area5State) {
		this.area5State = area5State;
	}

	public ToothState getArea6State() {
		return area6State;
	}

	public void setArea6State(final ToothState area6State) {
		this.area6State = area6State;
	}

	public ToothState getArea7State() {
		return area7State;
	}

	public void setArea7State(final ToothState area7State) {
		this.area7State = area7State;
	}

	public ToothState getArea8State() {
		return area8State;
	}

	public void setArea8State(final ToothState area8State) {
		this.area8State = area8State;
	}

	public Visit getVisit() {
		return visit;
	}

	public void setVisit(final Visit visit) {
		this.visit = visit;
	}

	public Set<ToothActivity> getActivities() {
		return activities;
	}

	public void setActivities(final Set<ToothActivity> toothActivities) {
		this.activities = toothActivities;
	}

}
