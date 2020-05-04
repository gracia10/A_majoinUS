package exception;

public class AuthenticationException extends RuntimeException {

	private static final long serialVersionUID = 4769686546621850291L;

	public AuthenticationException() {
		super(ErrorCode.SESSION_EXPIRED.getMessage());
	}
	
	public AuthenticationException(String msg) {
		super(msg);
	}
}
