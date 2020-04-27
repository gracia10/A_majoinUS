package controller.LSH.exceptor;

public class AuthorizationException extends RuntimeException {

	public AuthorizationException() {
		super();
	}
	
	public AuthorizationException(String msg) {
		super(msg);
	}
}
