package com.newtronics.tx.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.newtronics.tx.dao.PlanDao;
import com.newtronics.tx.model.Plan;

@Repository
public class PlanDaoImpl implements PlanDao {
	@PersistenceContext
	private EntityManager em;

	@Value("${page.size}")
	private int pageSize;
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public Plan insertPlan(Plan plan) {
		em.persist(plan);
		return plan;
	}
	
	@Override
	public Long getPageCount() {
		Query query = em.createQuery("select count(p) from Plan p");
		Long count = (Long) query.getSingleResult();
		return count/pageSize;
	}

	@Override
	public List<Plan> listPlan(int page) {
		
		Query query = em.createQuery("from Plan");
		query.setFirstResult(page);
		query.setMaxResults(pageSize);
		@SuppressWarnings("unchecked")
		List<Plan> result = query.getResultList();

		return result;
	}

	@Override
	public Plan findPlanById(String planId) {
		@SuppressWarnings("unchecked")
		List<Plan> result = em.createQuery("from Plan where planId=:planId").setParameter("planId", planId)
				.getResultList();
		if (result.isEmpty()) {
			return null;
		}
		return result.get(0);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public Plan updatePlan(Plan plan) {
		return em.merge(plan);
	}

	@Override
	public int getNextPlanId(String templateId, int year, int month, int date) {
		@SuppressWarnings("unchecked")
		List<Plan> plans = em.createQuery(
				"from Plan where templateId=:templateId and year(createDate)=:year and month(createDate)=:month and day(createDate)=:date")
				.setParameter("templateId", templateId).setParameter("year", year).setParameter("month", month + 1)
				.setParameter("date", date).getResultList();
		return plans.size() + 1;
	}
}
