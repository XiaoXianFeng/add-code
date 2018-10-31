/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.newtronics.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

	@Autowired
	private UserService userService;

	@RequestMapping(value = "users.html", method = RequestMethod.GET)
	public ModelAndView defaultPage() {
		List<User> users = userService.getAllUsers();
		ModelAndView mv = new ModelAndView();
		mv.setViewName("users");
		mv.addObject("users", users);
		return mv;
	}

	@RequestMapping(value = "edit/{username}.html", method = RequestMethod.GET)
	public ModelAndView editUser(@PathVariable("username") String username) {
		User user = userService.getUserByName(username);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("editUser");
		mv.addObject("user", user);
		return mv;
	}

	@RequestMapping(value = "update/update.html", method = RequestMethod.POST)
	public String update(@Valid @ModelAttribute("user") User user, BindingResult result, ModelMap model) {
		if (result.hasErrors()) {
			return "user";
		}
		// model.addAttribute("name", employee.getName());
		// model.addAttribute("contactNumber", employee.getContactNumber());
		// model.addAttribute("id", employee.getId());
		return "users";
	}
	
	@RequestMapping(value = "create/default.html", method = RequestMethod.GET)
	public ModelAndView createDefault() {

		ModelAndView mv = new ModelAndView();
		mv.setViewName("createUser");
		mv.addObject("user", new User());
		return mv;
	}
	
	@RequestMapping(value = "create/create.html", method = RequestMethod.POST)
	public String create(@Valid @ModelAttribute("user") User user, BindingResult result, ModelMap model) {
		if (result.hasErrors()) {
			return "user";
		}
		// model.addAttribute("name", employee.getName());
		// model.addAttribute("contactNumber", employee.getContactNumber());
		// model.addAttribute("id", employee.getId());
		userService.insertUser(user);
		return "users";
	}
	
}
