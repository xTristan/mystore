<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script type="text/javascript" src="../jquery-ui/js/jquery.min.js"></script>
<script type="text/javascript" src="../jquery-ui/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="../json/json2.js"></script>
<link type="text/css" href="../common/style.css" rel="stylesheet" />
<link type="text/css" href="../jquery-ui/css/dark-hive/jquery-ui-1.8.13.custom.css" rel="stylesheet" />
<link type="text/css" href="buyer-style.css" rel="stylesheet" />	
<script type="text/javascript" src="buyer.js"></script>

<title>Welcome to MyStore</title>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function(){
			$("form td.label").addClass("form-label");
			$(".accordion").accordion({ header: "h3" });
		});
	</script>
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
			<td align="right"><a href=<%= userService.createLogoutURL(request.getRequestURI()) %>>sign out</a></td>
		</tr>
	</table>
	<form class="ui-state-default ui-corner-all" action="home.jsp" method="post" 
		  onsubmit="submitItemRequest(this,'<%= userEmail %>');return false;">
		<table style="margin-top:5px">
			<tr>
				<td class="label">what</td>
				<td><input type="text" name="what"></td>
			</tr>
			<tr>
				<td class="label">when</td>
				<td><input type="text" name="when"></td>
			</tr>
			<tr>
				<td class="label">where</td>
				<td><input type="text" name="where"></td>
			</tr>
			<tr>
				<td><input class="ui-state-default ui-corner-all" type="submit" value="Submit"/></td>
				<td align="right"><input class="ui-state-default ui-corner-all" type="reset" value="Reset"/></td>
			</tr>
		</table>
	</form>
	<table style="width:100%">
		<tr>
			<td style="width:50%;vertical-align:top">
				<!-- Accordion -->
				<label class="demoHeaders">Requests I've Made</label>
				<div class="accordion" id="requests_list" ></div>
			</td>
			<td style="width:50%;vertical-align:top">
				<label class="demoHeaders">Replies I've Received</label>
				<div class="accordion" id="response_list" ></div>
			</td>
		</tr>
	</table>

	<script type="text/javascript">
		<%-- setTimeout(function() {pullForRequestsMadeByTheUser("<%= userEmail %>", "");}, 5000); --%>
		pullForRequestsMadeByTheUser("<%= userEmail %>", "");
	</script>
<%
	} else {
%>
	<p>Hello</p>
	<p><a href=<%= userService.createLoginURL(request.getRequestURI()) %>>sign in</a></p>
<%
	}
%>
</body>
</html>