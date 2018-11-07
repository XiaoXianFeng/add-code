package com.newtronics.tx.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.newtronics.tx.dao.TemplateDao;
import com.newtronics.tx.dao.UserDAO;
import com.newtronics.tx.model.Template;
import com.newtronics.tx.model.User;
import com.newtronics.tx.service.TemplateService;

@Service
public class TemplateServiceImpl implements TemplateService {
	@Autowired
	private TemplateDao templateDao;

	@Autowired
	private UserDAO userDAO;
	
	@Override
	public List<Template> findAllTemplates() {
		//
		return templateDao.findAllTemplates();
	}

	@Override
	public List<Template> findAllTemplatesByCreator(String username) {
		//
		return templateDao.findAllTemplatesByCreator(username);
	}
	
	@Override
	public Template findTemplateById(String templateId) {
		return templateDao.findTemplateById(templateId);
	}

	
	@Override
	public Template findTemplateById(String templateId, boolean includeDisabled) {
		return templateDao.findTemplateById(templateId, includeDisabled);
	}
	
	@Override
	@Transactional(rollbackOn = { Exception.class })
	public void insertTemplate(Template template) throws Exception {
		Template t = templateDao.findTemplateById(template.getId(), true);
		if (t != null) {
			throw new Exception("Tempate exists");
		}
		List<User> users = new ArrayList<User>();
		template.setCreators(users);
		String str = template.getCreatorNames();
		if(str != null) {
			String[] userNames = str.split(",");
			for (String name : userNames) {
				User user = userDAO.getUserByName(name);
				if(user != null) {
					users.add(user);
				}
			}
		}
		
		users = new ArrayList<User>();
		template.setReviewers(users);
		str = template.getReviewerNames();
		if(str != null) {
			String[] userNames = str.split(",");
			for (String name : userNames) {
				User user = userDAO.getUserByName(name);
				if(user != null) {
					users.add(user);
				}
			}
		}
		
		users = new ArrayList<User>();
		template.setApprovers(users);
		str = template.getApproverNames();
		if(str != null) {
			String[] userNames = str.split(",");
			for (String name : userNames) {
				User user = userDAO.getUserByName(name);
				if(user != null) {
					users.add(user);
				}
			}
		}
		
		templateDao.insertTemplate(template);
	}

	@Override
	@Transactional(rollbackOn = { Exception.class })
	public Template updateTemplate(Template template) throws Exception {
		Template t = templateDao.findTemplateById(template.getId());
		if (t == null) {
			throw new Exception("Tempate not exists");
		}
		
		List<User> users = new ArrayList<User>();
		template.setCreators(users);
		String str = template.getCreatorNames();
		if(str != null) {
			String[] userNames = str.split(",");
			for (String name : userNames) {
				User user = userDAO.getUserByName(name);
				if(user != null) {
					users.add(user);
				}
			}
		}
		
		users = new ArrayList<User>();
		template.setReviewers(users);
		str = template.getReviewerNames();
		if(str != null) {
			String[] userNames = str.split(",");
			for (String name : userNames) {
				User user = userDAO.getUserByName(name);
				if(user != null) {
					users.add(user);
				}
			}
		}
		
		users = new ArrayList<User>();
		template.setApprovers(users);
		str = template.getApproverNames();
		if(str != null) {
			String[] userNames = str.split(",");
			for (String name : userNames) {
				User user = userDAO.getUserByName(name);
				if(user != null) {
					users.add(user);
				}
			}
		}
		
		t = templateDao.updateTemplate(template);
		return t;
	}

	

}
