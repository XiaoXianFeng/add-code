/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.newtronics.controller;

import java.security.Principal;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.beanutils.PropertyUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.newtronics.tx.model.Plan;
import com.newtronics.tx.model.PlanItem;
import com.newtronics.tx.model.Template;
import com.newtronics.tx.service.PlanService;
import com.newtronics.tx.service.TemplateService;

/**
 *
 * @author xiangweiwang
 */

@Controller
@RequestMapping(value = "/plan")
@SessionAttributes("plan")
public class PlanController {

	private Logger log = Logger.getLogger(PlanController.class);

	@Autowired
	private PlanService planService;

	@Autowired
	private TemplateService templateService;

	/**
	 * 显示所有的计划列表 TODO:加入查询条件
	 * 
	 * @return
	 */
	@RequestMapping(value = "list.html", method = RequestMethod.GET)
	public ModelAndView list(Principal principal) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("listPlan");

		// TODO:
		List<Plan> plans = planService.listPlan();
		mv.addObject("plans", plans);

		//
		List<Template> templates = templateService.findAllTemplatesByCreator(principal.getName());
		mv.addObject("templates", templates);
		return mv;
	}

	/**
	 * 从创建计划迁移而来，创建Plan对象并保持在内存中
	 * 
	 * @param templateId
	 * @return
	 */
	@RequestMapping(value = "input.html", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView inputPlan(@RequestParam(name = "templateId", required = false) String templateId,
			@RequestParam(name = "notifyNo", required = false) String notifyNo,
			@RequestParam(name = "planId", required = false) String planId) {
		ModelAndView mv = new ModelAndView();
		Plan plan = null;
		String tid = templateId;
		if (StringUtils.isEmpty(notifyNo)) {
			// 新建计划
			plan = new Plan();
		} else {
			// 打开已有计划，查询DB
			plan = planService.findPlanById(planId);
			if(plan != null) {
				tid = plan.getTemplateId();
			}
		}
		if (plan == null || StringUtils.isEmpty(tid)) {
			// TODO:
			// 数据校验
			mv.addObject("error", "未找到该计划，请刷新页面");
			mv.addObject("returnPage", "/do/plan/list.html");
			mv.setViewName("error");
			return mv;
		}

		Template template = templateService.findTemplateById(tid);
		if (template == null) {
			// TODO
			// 数据校验
		}

		// 若客户未设定，把模板客户名设为客户
		if (StringUtils.isEmpty(plan.getCustomer())) {
			plan.setCustomer(template.getName());
		}
		if (StringUtils.isEmpty(plan.getTemplateId())) {
			plan.setTemplateId(tid);
		}

		mv.setViewName(template.getViewName());
		mv.addObject("plan", plan);

		return mv;
	}

	/**
	 * 保存计划的数据项目 如果Session中的Plan对象未持续化，则插入到DB，否则更新DB
	 * 
	 * @param principal
	 * @param modelMap
	 * @param name
	 * @param value
	 * @param pk
	 * @return
	 */
	@RequestMapping(value = "save.html", method = RequestMethod.POST)
	@ResponseBody
	public String saveItem(Principal principal, ModelMap modelMap, @RequestParam("name") String name,
			@RequestParam("pk") String pk, @RequestParam(name = "value", required = false) String value,
			@RequestParam(name = "value[]", required = false) String values) {

		Plan plan = (Plan) modelMap.get("plan");
		if (plan == null || principal == null || StringUtils.isEmpty(principal.getName())) {
			return "已过期，请重新登陆";
		}
		String response = "成功";
		try {
			// PlanItem表存在此项目，则更新PlanItem表
			if (PropertyUtils.isReadable(plan, name) && PropertyUtils.isWriteable(plan, name)) {
				BeanUtils.setProperty(plan, name, value == null ? values : value);
			} else {
				Map<String, PlanItem> items = plan.getPlanItems();
				PlanItem item = items.get(name);
				if (item == null) {
					item = new PlanItem();
					items.put(name, item);
				}
				item.setPlan(plan);
				item.setItemName(pk);
				item.setItemValue(value == null ? values : value);
			}

			if (StringUtils.isEmpty(plan.getNotifyNo())) {
				plan = planService.insertPlan(plan);
			} else {
				plan = planService.updatePlan(plan);
			}
			modelMap.put("plan", plan);
		} catch (Exception e) {
			log.error(e.getMessage());
			response = "发生错误";
		}
		return response;
	}

	@RequestMapping(value = "submitReview.html", method = RequestMethod.POST)
	public ModelAndView submitReview(Principal principal, ModelMap modelMap, @RequestParam("planId") String planId) {
		ModelAndView mv = new ModelAndView();

		try {
			Plan plan = (Plan) modelMap.get("plan");//planService.findPlanById(planId);
			if(plan == null || StringUtils.isEmpty(plan.getTemplateId())) {
				mv.addObject("error", "未找到该计划，请刷新页面");
				mv.addObject("returnPage", "/do/plan/list.html");
				mv.setViewName("error");
				return mv;
			}
			planService.submitPlanForReview(plan);
		} catch (Exception e) {
			log.error(e.getMessage());
		}

		//success
		mv.setViewName("listPlan");
		List<Plan> plans = planService.listPlan();
		mv.addObject("plans", plans);
		return mv;
	}
}
