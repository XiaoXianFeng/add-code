package com.newtronics.tx.model;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.MapKey;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Version;

import com.newtronics.common.ApproveResult;
import com.newtronics.common.PlanStatus;

@Entity
public class Plan {
	// 主键
	@Id
	private String planId;

	private String templateId;
	
	// 创建日
	@Column(name = "create_date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date createDate;

	// 客户名
	private String customer;

	// 通知书号码
	private String notifyNo;

	// 版本号
	@Version
	private int versionNo;

	//1: submitted to review
	//2: approved
	//0: 
	@Enumerated(EnumType.STRING)
	private PlanStatus status;
	
	// 创建者`
	@OneToOne(cascade = CascadeType.DETACH)
	@JoinColumn(name = "creator_name")
	private User creator;

	// 审核者`
	@OneToOne(cascade = CascadeType.DETACH)
	@JoinColumn(name = "reviewer_name")
	private User reviewer;

	// 审核日
	@Column(name = "review_date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date reviewDate;

	@Enumerated(EnumType.ORDINAL)
	private ApproveResult reviewStatus;
	
	// 承认者
	@OneToOne(cascade = CascadeType.DETACH)
	@JoinColumn(name = "approver_name")
	private User approver;

	// 承认日
	@Column(name = "approve_date")
	@Temporal(TemporalType.TIMESTAMP)
	private Date approveDate;

	@Enumerated(EnumType.ORDINAL)
	private ApproveResult approveStatus;
	
	//
	@OneToMany(mappedBy = "plan", cascade = { CascadeType.ALL }, fetch=FetchType.EAGER)
	@MapKey(name = "itemName")
	private Map<String, PlanItem> planItems;

	@Column
	@Temporal(TemporalType.TIMESTAMP)
	private Date updateDate;
	
	private String message;
	
	public Plan() {
		this.planId = UUID.randomUUID().toString().replaceAll("-", "");
		this.createDate = new Date();
		this.status = PlanStatus.CREATING;
		this.reviewStatus = ApproveResult.NONE;
		this.approveStatus = ApproveResult.NONE;
	}

	public String getPlanId() {
		return planId;
	}

	public void setPlanId(String planId) {
		this.planId = planId;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getCustomer() {
		return customer;
	}

	public void setCustomer(String customer) {
		this.customer = customer;
	}

	public String getNotifyNo() {
		return notifyNo;
	}

	public void setNotifyNo(String notifyNo) {
		this.notifyNo = notifyNo;
	}

	public User getCreator() {
		return creator;
	}

	public void setCreator(User creator) {
		this.creator = creator;
	}

	public User getReviewer() {
		return reviewer;
	}

	public void setReviewer(User reviewer) {
		this.reviewer = reviewer;
	}

	public User getApprover() {
		return approver;
	}

	public void setApprover(User approver) {
		this.approver = approver;
	}

	public int getVersionNo() {
		return versionNo;
	}

	public void setVersionNo(int versionNo) {
		this.versionNo = versionNo;
	}

	public Date getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}

	public Date getApproveDate() {
		return approveDate;
	}

	public void setApproveDate(Date approveDate) {
		this.approveDate = approveDate;
	}

	public Map<String, PlanItem> getPlanItems() {
		if(planItems == null) {
			planItems = new HashMap<String, PlanItem>();
		}
		return planItems;
	}

	public void setPlanItems(Map<String, PlanItem> planItems) {
		this.planItems = planItems;
	}

	public PlanStatus getStatus() {
		return status;
	}

	public void setStatus(PlanStatus status) {
		this.status = status;
	}

	public String getTemplateId() {
		return templateId;
	}

	public void setTemplateId(String templateId) {
		this.templateId = templateId;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public ApproveResult getReviewStatus() {
		return reviewStatus;
	}

	public void setReviewStatus(ApproveResult reviewStatus) {
		this.reviewStatus = reviewStatus;
	}

	public ApproveResult getApproveStatus() {
		return approveStatus;
	}

	public void setApproveStatus(ApproveResult approveStatus) {
		this.approveStatus = approveStatus;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	
}
