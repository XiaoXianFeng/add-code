package com.newtronics.tx.service.impl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.newtronics.common.PlanStatus;
import com.newtronics.tx.dao.PlanDao;
import com.newtronics.tx.dao.TemplateDao;
import com.newtronics.tx.model.Plan;
import com.newtronics.tx.model.Template;
import com.newtronics.tx.service.PlanService;

@Service
public class PlanServiceImpl implements PlanService {

	private Logger log = Logger.getLogger(PlanServiceImpl.class);

	@Autowired
	private PlanDao planDAO;

	@Autowired
	private TemplateDao templateDao;

	/**
	 * 新创建一个Plan对象
	 */
	@Override
	@Transactional
	public Plan insertPlan(Plan plan) {
		log.info("insertPlan");
		if (StringUtils.isEmpty(plan.getNotifyNo())) {
			Calendar c = Calendar.getInstance();
			c.setTime(plan.getCreateDate());
			int nextId = planDAO.getNextPlanId(plan.getTemplateId(), c.get(Calendar.YEAR), c.get(Calendar.MONTH),
					c.get(Calendar.DATE));
			log.debug("nextId:" + nextId);
			Template template = templateDao.findTemplateById(plan.getTemplateId());

			String f = template.getNotifiyNoFormat();
			f = f.replace("%yy%", String.format("%04d", c.get(Calendar.YEAR)));
			f = f.replace("%mm%", String.format("%02d", c.get(Calendar.MONTH) + 1));
			f = f.replace("%dd%", String.format("%02d", c.get(Calendar.DATE)));
			log.debug(String.format("Template Name:%s, notifyNo format:", template.getName(),
					template.getNotifiyNoFormat(), template.getViewName()));
			f = String.format(f, nextId);
			plan.setNotifyNo(f);
		}

		return planDAO.insertPlan(plan);
	}

	/**
	 * 更新一个Plan对象
	 */
	@Override
	@Transactional
	public Plan updatePlan(Plan plan) {
		return planDAO.updatePlan(plan);
	}

	/**
	 * 更新一个Plan对象
	 */
	public Plan findPlanById(String planId) {
		return planDAO.findPlanById(planId);
	}

	@Override
	public Long getPageCount() {
		return planDAO.getPageCount();
	}

	@Override
	public List<Plan> listPlan(int page) {
		return planDAO.listPlan(page);
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public Plan submitPlanForReview(Plan plan) {
		if (plan.getStatus() != PlanStatus.CREATING) {
			// exception
		}
		// 设置为review状态
		plan.setStatus(PlanStatus.REVIEWING);
		Plan p = planDAO.updatePlan(plan);
		return p;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public Plan reviewerApprove(Plan plan, boolean approve, String userName) {
		if (plan.getStatus() != PlanStatus.REVIEWING) {
			// exception
		}
		// 设置为approving状态
		plan.setStatus(approve ? PlanStatus.APPROVING : PlanStatus.CREATING);
		plan.setReviewDate(new Date());
		// TODO:
		// plan.setReviewer(reviewer);
		Plan p = planDAO.updatePlan(plan);
		return p;
	}

	@Transactional(propagation = Propagation.REQUIRED)
	public Plan approverApprove(Plan plan, boolean approve, String userName) {
		if (plan.getStatus() != PlanStatus.APPROVING) {
			// exception
		}
		// 设置为approve状态
		plan.setStatus(approve ? PlanStatus.APPROVED : PlanStatus.CREATING);
		plan.setApproveDate(new Date());
		// TODO:
		// plan.setApprover(approver);
		Plan p = planDAO.updatePlan(plan);
		return p;
	}
}
