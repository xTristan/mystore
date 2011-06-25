package com.mystore.model;

import java.io.Serializable;

import com.google.appengine.api.datastore.Key;

import javax.jdo.annotations.PersistenceCapable;
import javax.jdo.annotations.Persistent;
import javax.jdo.annotations.PrimaryKey;
import javax.jdo.annotations.IdGeneratorStrategy;
import javax.jdo.annotations.Unique;

@PersistenceCapable
public class User implements Serializable{
	private static final long serialVersionUID = 1L;

	@PrimaryKey
	@Persistent(valueStrategy = IdGeneratorStrategy.IDENTITY)
	private Key key;
	
	@Unique
	@Persistent
	private String name;
	
	@Persistent
	private String email;

	public User() {
		name = "";
		email = "";
	}
	
	public User(String name, String email) {
		this.name = name;
		this.email = email;
	}
	
	public Key getKey() { return key; }
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public static String getNameKey() { return "name"; }
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public static String getEmailKey() { return "email"; }
}
