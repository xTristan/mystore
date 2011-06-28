<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link type="text/css" href="/common/style.css" rel="stylesheet" />
		<link type="text/css" href="/jquery-ui/css/dark-hive/jquery-ui-1.8.13.custom.css" rel="stylesheet" />
		<script type="text/javascript" src="/jquery-ui/js/jquery.min.js"></script>
		<script type="text/javascript" src="/jquery-ui/js/jquery-ui.min.js"></script>		
	</head>
	<body>
		<header>
			<h1>My Store</h1>
			<nav>
				<ul>
					<li><a href="/seller/home.jsp">Sell</a></li>
					<li><a href="/buyer">Buy</a></li>
				</ul>
			</nav>
		<%
			UserService userService = UserServiceFactory.getUserService();
			User user = userService.getCurrentUser();
			
			if (user == null) {
		%>
			<div>
				<div class="horizontal">
					<label>Email</label><br/>
					<input type="text"/>
				</div>
				<div class="horizontal">
					<label>Password</label><br/>
					<input type="text"/>
				</div>
				<div class="horizontal">
					<br/>
					<div style="margin-top:2px">
						<a class="ui-state-default ui-corner-all button-like" href=<%=userService.createLoginURL(request.getRequestURI())%>>Login</a>
					</div>
				</div>
			</div>
		<%
			} else {	
		%>	
			<div class="profile-panel">
				<div>
					<%
						String email = user.getEmail();
						String emailAccount = email.substring(0, email.indexOf("@"));
					%>
					<span>Welcome <%= emailAccount.toUpperCase() %></span>
					<br/>
					<a href="/profile">Profile</a>
					<a href="/profile">Account</a>
					<a href=<%=userService.createLogoutURL(request.getRequestURI())%>>Log Out</a>
				</div>
			</div>	
		<%
			}
		%>
			<hr/>
		</header>