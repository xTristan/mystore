package com.mystore.errormanager;

public class ErrorEntry {
	private Object key;
	private ReturnCode errorCode;
	private String errorMessage;
	
	public ErrorEntry(Object key, ReturnCode ec) {
		this.key = key;
		this.errorCode = ec;
	}
	
	public void setKey(Object key) {
		this.key = key;
	}
	
	public Object getKey() {
		return key;
	}
	
	public void setErrorCode(ReturnCode errorCode) {
		this.errorCode = errorCode;
	}
	
	public ReturnCode getErrorCode() {
		return errorCode;
	}

	public void setErrorMessage(String errorMessage) {
		this.errorMessage = errorMessage;
	}

	public String getErrorMessage() {
		return errorMessage;
	}	
}
