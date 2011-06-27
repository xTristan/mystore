/**
 * 
 */

function addKeyword(userKey, newKeyword) {
	$.post('subscription', { type: "add_keyword_subscription", user_id: userKey, keyword: newKeyword}, addKeywordCallback)
}

function addKeywordCallback(resp) {
	$('#keywordList').append('<li><label>' + resp + '</label><input type="button" value="-"/></li>)
}