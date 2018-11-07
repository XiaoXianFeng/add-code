package com.newtronics.tx.dao;

import java.util.List;

import com.newtronics.tx.model.Plan;

public interface PlanDao {
	Plan insertPlan(Plan plan);

	Plan updatePlan(Plan plan);

	Long getPageCount();

	List<Plan> listPlan(int page);

	Plan findPlanById(String planId);

	int getNextPlanId(String templateId, int year, int month, int date);
}
