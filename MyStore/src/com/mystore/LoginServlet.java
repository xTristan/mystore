package com.mystore;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.mystore.errormanager.ErrorEntry;
import com.mystore.errormanager.ReturnCode;
import com.mystore.model.PersistenceManagerFactoryHelper;
import com.mystore.model.User;
import com.mystore.model.persistence.UserDB;

public class LoginServlet extends HttpServlet {
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String action = req.getPathInfo().toLowerCase();
		User user = extractUserFromRequest(req);
		ErrorEntry result = UserDB.manipulateUser(user, action);
		if (result != null)
			resp.getWriter().print(new Gson().toJson(result));
	}
	
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		doPost(req, resp); 
	}
	
	private static User extractUserFromRequest(HttpServletRequest req) {
		// TODO: Handle errors
		Map parameters = req.getParameterMap();
		String userName = req.getParameter(User.getNameKey()).trim();
		String email = req.getParameter(User.getEmailKey()).trim();
		return new User(userName, email);
	}
}
 