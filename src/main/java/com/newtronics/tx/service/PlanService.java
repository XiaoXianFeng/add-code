package com.newtronics.tx.service;

import java.util.List;

import com.newtronics.tx.model.Plan;

public interface PlanService {

	Plan insertPlan(Plan plan);

	Plan updatePlan(Plan plan);

	Plan findPlanById(String planId);

	Long getPageCount();

	List<Plan> listPlan(int page);

	Plan submitPlanForReview(Plan plan);
}
