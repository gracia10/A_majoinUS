package controller.LSH.exceptor;

public class AuthenticationException extends RuntimeException {

	public AuthenticationException() {
		super();
	}
	
	public AuthenticationException(String msg) {
		super(msg);
	}
}
