package com.newtronics.tx.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class PlanItem {

	@Id
	private String id;

	private String itemName;

	private String itemValue;

	@ManyToOne
	@JoinColumn(name = "PLAN_ID")
	private Plan plan;

	public PlanItem() {
		this.id = UUID.randomUUID().toString().replaceAll("-", "");
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}


	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getItemValue() {
		return itemValue;
	}

	public void setItemValue(String itemValue) {
		this.itemValue = itemValue;
	}

	public Plan getPlan() {
		return plan;
	}

	public void setPlan(Plan plan) {
		this.plan = plan;
	}

}
