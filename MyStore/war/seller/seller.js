function validateProfileFormAndSubmit(form, id) {
	var userName = $('input[name="username"]', form)[0].value;
	var userEmail = $('input[name="email"]', form)[0].value;
	
	$.post("/save-profile",{id:id, user:userName, email:userEmail})
}