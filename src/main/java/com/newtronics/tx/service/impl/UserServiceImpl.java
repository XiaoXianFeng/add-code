package com.newtronics.tx.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.newtronics.tx.dao.UserDAO;
import com.newtronics.tx.model.Role;
import com.newtronics.tx.model.User;
import com.newtronics.tx.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDAO userDAO;

	@Override
	@Transactional
	public void insertUser(User user) {
		userDAO.insertUser(user);
	}

	@Override
	@Transactional
	public User updateUser(User user) {
		User u = userDAO.updateUser(user);
		return u;
	}

	@Override
	public User getUserByName(String username) {
		return userDAO.getUserByName(username);
	}

	@Override
	public List<User> getAllUsers() {
		return userDAO.getAllUsers();
	}


	@Override
	public List<Role> getAllRoles() {
		return userDAO.getAllRoles();
	}

}
