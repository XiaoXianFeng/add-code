package com.newtronics.tx.model;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.OneToMany;
import javax.persistence.PostLoad;
import javax.persistence.Transient;

/**
 * 计划模板文件·
 * 
 * name:名称，设想用公司名 viewName：对应JSP文件名 notifiyNoFormat：通知书号码格式 enabled：删除标记
 * 
 * @author wang_
 *
 */

@Entity
public class Template {
	// 主键，随机生成的唯一标识
	@Id
	private String id;

	// 模板名称
	private String name;

	// JSP file name
	private String viewName;

	// 格式
	private String notifiyNoFormat;

	private int enabled;

	// private String creators;
	//
	// private String reviewers;
	//
	// private String approvers;

	@OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(name = "template_creator", joinColumns = {
			@JoinColumn(name = "template_id", referencedColumnName = "id") }, inverseJoinColumns = {
					@JoinColumn(name = "user_id", referencedColumnName = "username") })
	private List<User> creators;

	@OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(name = "template_reviewer", joinColumns = {
			@JoinColumn(name = "template_id", referencedColumnName = "id") }, inverseJoinColumns = {
					@JoinColumn(name = "user_id", referencedColumnName = "username") })
	private List<User> reviewers;

	@OneToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(name = "template_approver", joinColumns = {
			@JoinColumn(name = "template_id", referencedColumnName = "id") }, inverseJoinColumns = {
					@JoinColumn(name = "user_id", referencedColumnName = "username") })
	private List<User> approvers;

	@Transient
	private String creatorNames;

	@Transient
	private String reviewerNames;

	@Transient
	private String approverNames;

	public Template() {
		this.id = UUID.randomUUID().toString().replaceAll("-", "");
		this.enabled = 1;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getViewName() {
		return viewName;
	}

	public void setViewName(String viewName) {
		this.viewName = viewName;
	}

	public String getNotifiyNoFormat() {
		return notifiyNoFormat;
	}

	public void setNotifiyNoFormat(String notifiyNoFormat) {
		this.notifiyNoFormat = notifiyNoFormat;
	}

	public int getEnabled() {
		return enabled;
	}

	public void setEnabled(int enabled) {
		this.enabled = enabled;
	}

	public List<User> getCreators() {
		if (creators == null) {
			creators = new ArrayList<User>();
		}
		return creators;
	}

	public void setCreators(List<User> creators) {
		this.creators = creators;
	}

	public List<User> getReviewers() {
		if (reviewers == null) {
			reviewers = new ArrayList<User>();
		}
		return reviewers;
	}

	public void setReviewers(List<User> reviewers) {
		this.reviewers = reviewers;
	}

	public List<User> getApprovers() {
		if (approvers == null) {
			approvers = new ArrayList<User>();
		}
		return approvers;
	}

	public void setApprovers(List<User> approvers) {
		this.approvers = approvers;
	}

	public String getCreatorNames() {
		return creatorNames;
	}

	public void setCreatorNames(String creatorNames) {
		this.creatorNames = creatorNames;
	}

	public String getReviewerNames() {
		return reviewerNames;
	}

	public void setReviewerNames(String reviewerNames) {
		this.reviewerNames = reviewerNames;
	}

	public String getApproverNames() {
		return approverNames;
	}

	public void setApproverNames(String approverNames) {
		this.approverNames = approverNames;
	}
	
	@PostLoad
	public void populateNames() {
		StringBuilder sb = new StringBuilder();
		for (User user : this.getCreators()) {
			sb.append(user.getUsername()).append(",");
		}
		this.setCreatorNames(sb.toString());
		sb.setLength(0);
		
		for (User user : this.getReviewers()) {
			sb.append(user.getUsername()).append(",");
		}
		this.setReviewerNames(sb.toString());
		sb.setLength(0);
		
		for (User user : this.getApprovers()) {
			sb.append(user.getUsername()).append(",");
		}
		this.setApproverNames(sb.toString());
	}
}
