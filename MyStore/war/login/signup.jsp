<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create New Account</title>
<script type="text/javascript" src="../jquery-ui/js/jquery.min.js"></script>
<script type="text/javascript" src="login.js"></script>
<style>
	.start-hidden { display:none; width:240px }
	.error-message { color: #FF0000; font-size: 12px}
</style>
</head>
<body>
<!-- TODO: make sure no access to this page when already logged on -->
	<form id="new_user_profile_form" method="get">
		<table>
			<tr>
				<td>Choose a User Name:</td>
				<td><input type="text" name="username"/></td>
			</tr>
			<tr class="start-hidden error-message" id="userNameErrorText">
				<td colspan="2" align="left"/>
			</tr>
			<tr>
				<td>Email:</td>
				<td><input type="text" name="email"/></td>
			</tr>			
			<tr class="start-hidden error-message" id="emailErrorText">
				<td colspan="2" align="left"/>
			</tr>
			<tr>
				<td><input type="button" value="Submit" onClick="validateUserProfileAsync(this.form)"/>
				<td><input type="reset" value="Cancel"/> 
			</tr>
		</table>
	</form>
</body>
</html>