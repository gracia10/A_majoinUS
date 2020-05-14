package exception;

public class AuthorizationException extends RuntimeException {
	
	private static final long serialVersionUID = -259714620238272044L;

	public AuthorizationException() {
		super(ErrorCode.ACCESS_DENIED.getMessage());
	}
	
	public AuthorizationException(String msg) {
		super(msg);
	}
}
