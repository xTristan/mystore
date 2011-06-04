/**
 * 
 */

function submitItemRequest(form, userEmail) {
	var item = $('input[name="what"]', form)[0].value;
	var location = $('input[name="where"]', form)[0].value;
	var expiration = $('input[name="when"]', form)[0].value;
	$.get("/submit-request", {what:item, where:location, when:expiration, who:userEmail}, 
		submitItemRequestCallback);
}

function submitItemRequestCallback(data) {
}

function queryForRequestsCallback(data) {
	var new_requests = jQuery.parseJSON(data);
	if (new_requests != null) {
		for (var i = 0; i < new_requests.length; i++) {
			var new_request = new_requests[i];
			var date = new Date(new_request.propertyMap.timestamp)
			var html = '<div><h3><a href="#">' + date.toString() + '</a></h3><div>' + new_request.propertyMap.what + '</div></div>';
			var new_node = $(html);
			new_node.prependTo('#requests_list');
		}
	}
	var activeIndex = $( "#requests_list" ).accordion( "option", "active" );
	$("#requests_list").accordion("destroy");
	$("#requests_list").accordion({ header: "h3", active:activeIndex+new_requests.length});	
}

function pullForRequestsMadeByTheUser(userEmail, lastPullTimestamp) {
	var parameters = {}
	if (lastPullTimestamp != "") {
		parameters["after"] = lastPullTimestamp;
	}
	parameters["user"] = userEmail;
	$.get("/query-request.json", parameters, queryForRequestsCallback);
	
	var currentTimestamp = new Date().getTime();
	setTimeout(function() {pullForRequestsMadeByTheUser(userEmail, currentTimestamp)}, 5000);
}