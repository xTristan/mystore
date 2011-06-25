package com.mystore.model;

import javax.jdo.JDOHelper;
import javax.jdo.PersistenceManager;
import javax.jdo.PersistenceManagerFactory;
import javax.jdo.Transaction;

import com.mystore.errormanager.ErrorEntry;
import com.mystore.errormanager.ReturnCode;

import java.util.HashMap;

public class PersistenceManagerFactoryHelper {
	private static HashMap<String, PersistenceManagerFactory> factoryInstances;
	
	static {
		 factoryInstances = new HashMap<String, PersistenceManagerFactory>();
		 factoryInstances.put("transactions-optional", JDOHelper.getPersistenceManagerFactory("transactions-optional"));
		 factoryInstances.put("transactional-write", JDOHelper.getPersistenceManagerFactory("transactional-write"));
	}
	
	public static PersistenceManagerFactory getDefaultInstance () { return factoryInstances.get("transactions-optional"); }
	
	public static PersistenceManagerFactory getInstance(String key) {
		// TODO: Log4j if key is null;
		if (factoryInstances.containsKey(key))
			return factoryInstances.get(key);
		else 
			return null;
	}
	
	public static ErrorEntry makePersistentInTransaction(Object obj) {
		PersistenceManager pm = getInstance("transactional-write").getPersistenceManager();
		Transaction tx = pm.currentTransaction();
		ErrorEntry errorEntry = null;
		
		try {
			tx.begin();			
			pm.makePersistent(obj);			
			tx.commit();
		} 
		catch (Exception e) {
			errorEntry = new ErrorEntry(null, ReturnCode.TRANSACTION_COMMIT_FAILURE);
		} 
		finally {
			if (tx.isActive()) 
				tx.rollback();
			
			pm.close();
		}
		return errorEntry;
	}
}
