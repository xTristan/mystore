package com.mystore;

import java.io.IOException;
import java.util.List;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.mystore.model.KeywordSubscription;
import com.mystore.model.PersistenceManagerFactoryHelper;
import com.mystore.model.User;

public class SubscriptionServiceServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String type = req.getParameter("type");
		Key userId = KeyFactory.stringToKey(req.getParameter("user_id"));
		
		if (type.toLowerCase() == "add_keyword_subscription") {
			String newKeyword = req.getParameter("keyword");
			addKeywordSubscription(userId, newKeyword, resp);
		}
	}
	
	private void addKeywordSubscription(Key userId, String newKeyword, HttpServletResponse response) throws IOException{
		PersistenceManager pmInstance = PersistenceManagerFactoryHelper.getDefaultInstance().getPersistenceManager();
		
		User subscriber = pmInstance.getObjectById(User.class, userId);
		KeywordSubscription newKS = new KeywordSubscription(subscriber, newKeyword);
		try {
			pmInstance.makePersistent(newKS);
		} finally {
			pmInstance.close();
		}
				
		response.getWriter().print(newKeyword);
		// TODO: some IO Exception handling
	}
}
