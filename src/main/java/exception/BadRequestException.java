package exception;

public class BadRequestException extends RuntimeException {

	private static final long serialVersionUID = -4617369486674362250L;

	public BadRequestException() {
	}
	
	public BadRequestException(String msg) {
		super(msg);
	}
}
