package com.mystore;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.*;

@SuppressWarnings("serial")
public class RequestReceiverServiceServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		DatastoreService dbService = DatastoreServiceFactory.getDatastoreService();
		Entity entity = new Entity("Request");
		entity.setProperty("what", req.getParameter("what"));
		entity.setProperty("where", req.getParameter("where"));
		entity.setProperty("when", req.getParameter("when"));
		entity.setProperty("who", req.getParameter("who").toLowerCase());
		entity.setProperty("timestamp", new Date());
		// TODO catch exceptions
		dbService.put(entity);
	}
}
