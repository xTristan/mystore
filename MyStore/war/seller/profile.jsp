<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
%>
	<!-- validate and submit the form asynchronously, and only redirect if the form is successfully submitted -->
	<form  style="width:80%;margin-left:30px" class="ui-state-default ui-corner-all" action="home.jsp" method="post" 
		  onsubmit="validateProfileFormAndSubmit(this,'<%= userEmail %>');return false;">
	</form>
<%
	}
%>
</body>
</html>