/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.newtronics.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.newtronics.tx.model.User;
import com.newtronics.tx.service.UserService;

/**
 *
 * @author xiangweiwang
 */
@Controller
@RequestMapping(value = "/user")
public class UserController {
	private Logger log = Logger.getLogger(UserController.class);

	@Autowired
	private UserService userService;

	/**
	 * 顯示用戶列表
	 * 
	 * @return
	 */
	@RequestMapping(value = "users.html", method = RequestMethod.GET)
	public ModelAndView users() {
		List<User> users = userService.getAllUsers();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("users");
		mv.addObject("users", users);
		return mv;
	}

	/**
	 * 顯示編輯用戶頁面
	 * 
	 * @param username
	 * @return
	 */
	@RequestMapping(value = "edit/", method = RequestMethod.GET)
	public ModelAndView editUser(@RequestParam("username") String username) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("editUser");
		if (StringUtils.isEmpty(username)) {
			mv.addObject("error", "参数错误");
			return mv;
		}
		User user = userService.getUserByName(username);
		if (user == null) {
			mv.addObject("error", "没找到这个用户");
			return mv;
		}
		if (user.getRoles() != null && !user.getRoles().isEmpty()) {
			user.setUserRole(user.getRoles().get(0));
		}
		mv.setViewName("editUser");
		mv.addObject("user", user);
		return mv;
	}

	/**
	 * 更新用戶信息
	 * 
	 * @param user
	 * @param result
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "update/", method = RequestMethod.POST)
	public ModelAndView update(Principal principal, @ModelAttribute("user") User user, BindingResult result,
			ModelMap model) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("editUser");

		if (user == null || principal == null) {
			mv.addObject("error", "已过期，请重新登陆");
			mv.setViewName("error");
			return mv;
		}

		mv.addObject("user", user);

		if (!StringUtils.isEmpty(user.getPassword()) || !StringUtils.isEmpty(user.getPassword2())) {
			if (!user.getPassword().equals(user.getPassword2())) {
				mv.addObject("error", "用户密码和用户确认密码不一致");
				return mv;
			}
		}

		User u = userService.getUserByName(user.getUsername());
		if (u == null) {
			mv.addObject("error", "用户ID不存在");
			return mv;
		}

		if (!StringUtils.equals(user.getUserDispName(), u.getUserDispName())) {
			u.setUserDispName(user.getUserDispName());
		}

		if (!StringUtils.equals(user.getEmail(), u.getEmail())) {
			u.setEmail(user.getEmail());
		}

		if (!StringUtils.isEmpty(user.getPassword())) {
			u.setPassword(user.getPassword());
		}

		u.setEnabled(user.getEnabled());

		if (u.getRoles() == null) {
			u.setRoles(new ArrayList<String>());
		}

		// we only have one role
		boolean roleFound = false;
		for (String role : u.getRoles()) {
			if (StringUtils.equals(role, user.getUserRole())) {
				roleFound = true;
				break;
			}
		}
		if (!roleFound) {
			u.getRoles().clear();
			u.getRoles().add(user.getUserRole());
		}

		if (StringUtils.isEmpty(u.getUsername())) {
			mv.addObject("error", "用户ID未输入");
			return mv;
		}
		if (StringUtils.isEmpty(u.getUserDispName())) {
			mv.addObject("error", "用户显示名未输入");
			return mv;
		}
		if (StringUtils.isEmpty(u.getPassword())) {
			mv.addObject("error", "用户密码未输入");
			return mv;
		}

		try {
			u = userService.updateUser(u);
		} catch (Exception e) {
			log.error(e.getMessage());
			mv.addObject("error", "发生错误");
			return mv;
		}
		return users();
	}

	/**
	 * 顯示創建用戶頁面
	 * 
	 * @return
	 */
	@RequestMapping(value = "create/", method = RequestMethod.GET)
	public ModelAndView createInit() {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("createUser");
		mv.addObject("user", new User());
		return mv;
	}

	/**
	 * 創建用戶
	 * 
	 * @param user
	 * @param result
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "create/create.html", method = RequestMethod.POST)
	public ModelAndView create(Principal principal, @ModelAttribute("user") User user, BindingResult result,
			ModelMap model) {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("createUser");
		mv.addObject("user", user);
		// List<Role> roles = userService.getAllRoles();
		// mv.addObject("roles", roles);

		if (user == null || principal == null) {
			mv.addObject("error", "已过期，请重新登陆");
			mv.setViewName("error");
			return mv;
		}
		if (StringUtils.isEmpty(user.getUsername())) {
			mv.addObject("error", "用户ID未输入");
			return mv;
		}
		if (StringUtils.isEmpty(user.getUserDispName())) {
			mv.addObject("error", "用户显示名未输入");
			return mv;
		}
		if (StringUtils.isEmpty(user.getPassword())) {
			mv.addObject("error", "用户密码未输入");
			return mv;
		}
		if (StringUtils.isEmpty(user.getPassword2())) {
			mv.addObject("error", "用户确认密码未输入");
			return mv;
		}
		if (!user.getPassword().equals(user.getPassword2())) {
			mv.addObject("error", "用户密码和用户确认密码不一致");
			return mv;
		}

		User u = userService.getUserByName(user.getUsername());
		if (u != null) {
			mv.addObject("error", "用户ID已存在");
			return mv;
		}

		user.setEnabled("1");

		if (user.getRoles() == null) {
			user.setRoles(new ArrayList<String>());
		}
		user.getRoles().add(user.getUserRole());

		userService.insertUser(user);

		return users();
	}

}
