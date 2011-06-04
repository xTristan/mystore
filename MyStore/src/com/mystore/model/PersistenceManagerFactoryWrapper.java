package com.mystore.model;

import javax.jdo.JDOHelper;
import javax.jdo.PersistenceManagerFactory;

public class PersistenceManagerFactoryWrapper {
	private static final PersistenceManagerFactory instance = 
		JDOHelper.getPersistenceManagerFactory("transactions-optional");
	
	private PersistenceManagerFactoryWrapper() {}
	
	public static PersistenceManagerFactory getInstance () { return instance; }
}
