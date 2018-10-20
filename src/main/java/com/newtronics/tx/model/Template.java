package com.newtronics.tx.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * 计划模板文件·
 * 
 * name:名称，设想用公司名
 * viewName：对应JSP文件名
 * notifiyNoFormat：通知书号码格式
 * enabled：删除标记
 * @author wang_
 *
 */

@Entity
public class Template {
	// 主键，随机生成的唯一标识
	@Id
	private String id;

	//模板名称
	private String name;

	//JSP file name
	private String viewName;
	
	//格式
	private String notifiyNoFormat;

	private int enabled;
	
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
}
