package com.newtronics.tx.model;

import java.util.List;

import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "USERS")
public class User {
	@Id
	private String username;

	private String userDispName;

	private String password;

	@Transient
	private String password2;

	@Transient
	private String userRole;

	private String email;

	private String enabled;

	@ElementCollection(targetClass = String.class, fetch = FetchType.EAGER)
	@CollectionTable(name = "user_role", joinColumns = {
			@JoinColumn(name = "username", referencedColumnName = "username") })
	@Column(name = "role")
	private List<String> roles;

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUserDispName() {
		return userDispName;
	}

	public void setUserDispName(String userDispName) {
		this.userDispName = userDispName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword2() {
		return password2;
	}

	public void setPassword2(String password2) {
		this.password2 = password2;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getEnabled() {
		return enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}

	public List<String> getRoles() {
		return roles;
	}

	public void setRoles(List<String> roles) {
		this.roles = roles;
	}

	public String getUserRole() {
		return userRole;
	}

	public void setUserRole(String role) {
		this.userRole = role;
	}
}
