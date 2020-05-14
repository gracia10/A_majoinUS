package exception;

public enum ErrorCode {
	
	BAD_REQUEST(400,"C001","잘못된 주소입니다."),
	SESSION_EXPIRED(403,"C002","로그인 정보가 없습니다. 다시 접속해 주세요."),
    ACCESS_DENIED(403,"C003","접근 권한이 없습니다."),
    NOT_FOUND(404,"C004","요청하신 페이지를 찾을 수 없습니다. 관련 문의사항은 고객센터에 말씀해주세요."),
    METHOD_NOT_ALLOWED(405,"C005","잘못된 접근입니다."),
    
    INTERNAL_SERVER_ERROR(500,"C005","서버에 문제가 발생했습니다. 관련 문의사항은 고객센터에 말씀해주세요."),
    ;
	
    private int status;
	private final String message;
	private final String code;

    ErrorCode(final int status,final String code, final String message) {
        this.status = status;
        this.message = message;
        this.code = code;
    }
    
    public int getStatus() {return status;}
    public String getCode() {return code;}
    public String getMessage() {return message;}
    
    
}
