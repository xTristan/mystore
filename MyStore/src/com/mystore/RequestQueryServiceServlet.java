package com.mystore;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.gson.*;

public class RequestQueryServiceServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		Query query = new Query("Request");
		Object minTimestamp = req.getParameter("after");
		Object maxTimestamp = req.getParameter("before");
		Object userEmail = req.getParameter("who");
		
		filterByUserEmail(query, userEmail);
		filterByTimeRange(query, minTimestamp, maxTimestamp, true);
		
		PreparedQuery preparedQuery = DatastoreServiceFactory.getDatastoreService().prepare(query);
		Gson gson = new Gson();
		String json = gson.toJson(preparedQuery.asList(FetchOptions.Builder.withDefaults()));
		resp.getWriter().print(json);
	}
	
	private void filterByUserEmail(Query query, Object userEmail) {
		if (userEmail != null) {
			query.addFilter("who", Query.FilterOperator.EQUAL, userEmail.toString().toLowerCase());
		}
	}
	
	private void filterByTimeRange(Query query, Object minTimestamp, Object maxTimestamp, boolean sort) {
		if (minTimestamp != null) {
			try {
				Long milliseconds = Long.parseLong(minTimestamp.toString());
				Date minDate = new Date(milliseconds);
				query.addFilter("timestamp", Query.FilterOperator.GREATER_THAN, minDate);
			}
			catch (NumberFormatException e) {
				//TODO: Do some logging
			}
		}
		if (maxTimestamp != null) {
			try {
				Long milliseconds = Long.parseLong(maxTimestamp.toString());
				Date maxDate = new Date(milliseconds);
				query.addFilter("timestamp", Query.FilterOperator.LESS_THAN, maxDate);
			}
			catch (NumberFormatException e) {
				//TODO: Do some logging
			}
		}	
		if (sort) 
			query.addSort("timestamp", Query.SortDirection.ASCENDING);
	}
}
