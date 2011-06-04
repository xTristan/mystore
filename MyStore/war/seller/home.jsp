<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link type="text/css" href="../common/style.css" rel="stylesheet" />
<link type="text/css" href="../jquery-ui/css/dark-hive/jquery-ui-1.8.13.custom.css" rel="stylesheet" />
<title>Welcome to MyStore</title>
</head>
<body>
<%
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();

	if (user != null) {
		String userEmail = user.getEmail();
		String lastPullTimestamp = "";
%>
	<table id="top_banner" style="width:100%">
		<tr>
			<td align="left"><label>hello <%= userEmail %></label>
			<td align="right">
				<a href="profile.jsp">Profile</a>
			</td>
			<td align="right">
				<a href=<%= userService.createLogoutURL(request.getRequestURI()) %>>sign out</a>
			</td>
		</tr>
	</table> 
<%
	}
%>
	<table style="width:100%">
		<tr>
			<td style="width:50%;vertical-align:top">
				<label class="demoHeaders">My Subscription</label>
			<%
				if (user == null) { 
			%>
				<p>You need to sign in to see your subscription</p>
			<%
				} else {
			%>
				<div class="accordioin" id="subscription_list"></div>
			<%
				}
			%>
			</td>
			<td style="width:50%;vertical-align:top">
				<label class="demoHeaders">Requests near Me</label>
				<div class="accordioin" id="nearby_requests_list"></div>
			</td>
		</tr>
	</table>
</body>
</html>