package utils;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

public final class CommonUtils{

	public static final String LOCAL = "지역";
	public static final String JOB = "직군";
	public static final String ID = "id";
	public static final String ADMIN = "amajoinus@gmail.com";
	
    public static final Object getAttribute(String key) {
        return RequestContextHolder.getRequestAttributes().getAttribute(key, RequestAttributes.SCOPE_SESSION);
    }
    
    public static final String getUserId() {
    	return (String) RequestContextHolder.getRequestAttributes().getAttribute(ID, RequestAttributes.SCOPE_SESSION);
    }
}
