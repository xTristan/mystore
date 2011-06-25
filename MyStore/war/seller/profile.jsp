<%@page import="com.mystore.model.KeywordSubscription"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.jdo.Query" %>
<%@ page import="javax.jdo.PersistenceManager" %>
<%@ page import="javax.jdo.PersistenceManagerFactory" %>
<%@ page import="com.mystore.model.PersistenceManagerFactoryHelper" %>
<%@ page import="com.mystore.model.KeywordSubscription" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="../jquery-ui/js/jquery.min.js"></script>
<script type="text/javascript" src="../jquery-ui/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="profile.js"></script>
<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	String title = (user == null) ? "Please login with your email" : user.getEmail();
%>
<title> <%= title %></title>
</head>
<body>
<%
	if (user == null) {
%>
	<p><a href=<%= userService.createLoginURL(request.getRequestURI()) %>>sign in</a></p>
	<p><a href="register.jsp">register</a></p>
<%
	} else {
		String userEmail = user.getEmail();		
		
		PersistenceManager pmInstance = PersistenceManagerFactoryHelper.getDefaultInstance().getPersistenceManager();
		Query userQuery = pmInstance.newQuery(com.mystore.model.User.class, "email == emailParam");
		userQuery.declareParameters("String emailParam");
		
		try {
			List<com.mystore.model.User> users = (List<com.mystore.model.User>)userQuery.execute(userEmail);
			if (users.size() == 0) {
				// needs login
			}
			else if (users.size() == 1) {
				Query keywordsQuery = pmInstance.newQuery(KeywordSubscription.class, "subscriber = subscriberKeyParam");
				keywordsQuery.declareParameters(Key.class.getName() + " subscriberKeyParam");
				List<KeywordSubscription> keywords = (List<KeywordSubscription>)keywordsQuery.execute(users.get(0).getKey());
%>
				
				<!-- validate and submit the form asynchronously, and only redirect if the form is successfully submitted -->
				<form style="width:80%;margin-left:30px" class="ui-state-default ui-corner-all" action="home.jsp" method="post" 
					  onsubmit="validateProfileFormAndSubmit(this,'<%= userEmail %>');return false;">
					<table class="ui-state-default ui-corner-all" >
					  <tr>
					  	<td>User Name:</td>
					  	<td><input type="text" name="username"></td>
					  </tr>
					  <tr>
					  	<td>Email:</td>
					  	<td><input type="text" name="email"></td>
					  </tr>
					  <tr>
					  	<td>
					  	  <ul id="keywordList">
					  	  <%
					  	  	for (KeywordSubscription ks : keywords) {
					  	  %>
					  		  <li>
					  		  	<label><%= ks.getKeyword() %></label>
					  		  	<input type="button" value="-"/>
					  		  </li>
					  	  <%
					  	  	}
					  	  %>
					  	  </ul>
					  	</td>
					  </tr>
					  <tr>
					  	<td><input type="text" style="width:50px"/></td>
					  	<td><input type="button" value="+"/></td>
					  </tr>
					  <tr>
						<td><input class="ui-state-default ui-corner-all" type="submit" value="Save Profile"/></td>
						<td align="right"><input class="ui-state-default ui-corner-all" type="reset" value="Cancel"/></td>
					  </tr>
					</table>
				</form>
<%
			}
			else {
				// error. corrupted user db. dump log
			}
		}
		finally {
			userQuery.closeAll();
		}
	}
%>
</body>
</html>