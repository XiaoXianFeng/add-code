package com.newtronics.tx.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;


import org.springframework.stereotype.Repository;

import com.newtronics.tx.dao.UserDAO;
import com.newtronics.tx.model.Role;
import com.newtronics.tx.model.User;
import org.springframework.transaction.annotation.Transactional;

@Repository
public class UserDAOImpl implements UserDAO {

	@PersistenceContext
	private EntityManager em;

	@Override
	@Transactional
	public void insertUser(User user) {
		em.persist(user);
	}

	@Override
	public User getUserByName(String username) {
		@SuppressWarnings("unchecked")
		List<User> users = em.createQuery("from User where username=:username").setParameter("username", username).getResultList();
		if(users.isEmpty()) {
			return null;
		} else {
			return users.get(0);
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> getAllUsers() {
		return em.createQuery("from User u order by u.username").getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Role> getAllRoles() {
		return em.createQuery("from Role r order by r.role").getResultList();
	}

	@Override
	public User updateUser(User user) {
		return em.merge(user);
	}

}
