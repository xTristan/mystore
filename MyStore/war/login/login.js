/**
 * 
 */

function validateUserProfileAsync(form) {
	var username = form.username.value;
	var eml = form.email.value;
	clearErrorText("#userNameErrorText, #emailErrorText");
	
	var isUserNameNonEmpty = validateNonEmptiness(username, function() { showErrorText("#userNameErrorText", "User name cannot be empty. "); })
	var isEmailNonEmpty = validateNonEmptiness(eml, function() { showErrorText("#emailErrorText", "Email cannot be empty. "); })
	var isEmailValid = validateEmailAddressFormat(eml, function() { showErrorText("#emailErrorText", "Invalid Email format. "); })
	
	// client-side validation against empty user names/emails and email format
	if (isUserNameNonEmpty && isEmailNonEmpty && isEmailValid) {
		$.get('insert', {name: username, email: eml}, validateUserProfileCallback); 
	}
}

function validateUserProfileCallback(data) {
	if (data != null) {
		var response = $.parseJSON(data);
		if (response != null) {
			if (response.key == "name") {
				showErrorText("#userNameErrorText", response.errorCode); 
			}
		}
	}	
}

function validateNonEmptiness(str, callback) {
	var result = str != "";
	if (result == false) 
		callback();
	
	return result;
}

function validateEmailAddressFormat(address, callback) {
	var pattern = /^(\w|\d|\.|_)+@(\w|\d|_)+\.(\w)+$/i;
	var result = pattern.test(address);
	
	if (result == false) 
		callback();
	
	return result;
}

function clearErrorText(elementIds) {
	$(elementIds).find("td").html("");
}


function showErrorText(elementId, errorText) {
	var element = $(elementId);
	var cells = $("td:first", element); 
	cells.append(errorText);
	element.show("fast");
}