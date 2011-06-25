package com.mystore.model.persistence;

import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;

import com.mystore.model.PersistenceManagerFactoryHelper;
import com.mystore.model.User;
import com.mystore.errormanager.ErrorEntry;
import com.mystore.errormanager.ReturnCode;

public class UserDB {
	public static ErrorEntry insert(User user) {
		if (isNameUnique(user))
			return PersistenceManagerFactoryHelper.makePersistentInTransaction(user);
		else 
			return new ErrorEntry("name", ReturnCode.VALUE_DUPLICATE);
	}
	
	public static ErrorEntry update(User user) {
		return null;
	}
	
	public static ErrorEntry delete(User user) {
		return null;
	}
	
	public static boolean isNameUnique(User user) {
		PersistenceManager pmInstance = PersistenceManagerFactoryHelper.getDefaultInstance().getPersistenceManager();

		Query uniquenessQuery = pmInstance.newQuery(User.class);
		uniquenessQuery.setFilter("name == nameParameter");
		uniquenessQuery.declareParameters("String nameParameter");
		
		List<User> users = (List<User>)uniquenessQuery.execute(user.getName());
		return users.isEmpty();
	}
	
	public static ErrorEntry manipulateUser(User user, String action) {
		if (action.toLowerCase().equals("/insert"))
			return insert(user);
		else if (action.toLowerCase().equals("/delete"))
			return delete(user);
		else if (action.toLowerCase().equals("/update"))
			return update(user);
		else
			return new ErrorEntry(user, ReturnCode.OPERATION_UNSUPPORTED);
	}
}
