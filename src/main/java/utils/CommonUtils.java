package utils;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

public class CommonUtils{

	public static final String id = "id";
	public static final String admin = "amajoinus@gmail.com";
	
    public static Object getAttribute(String key) {
        return RequestContextHolder.getRequestAttributes().getAttribute(key, RequestAttributes.SCOPE_SESSION);
    }
    
    public static String getUserId() {
    	return (String) RequestContextHolder.getRequestAttributes().getAttribute(id, RequestAttributes.SCOPE_SESSION);
    }

//    public static void setAttribute(Attribute attribute) {
//        RequestContextHolder.getRequestAttributes().setAttribute(Attribute.KEY, attribute, RequestAttributes.SCOPE_SESSION);
//    }
//
//    public static void removeAttribute() {
//        RequestContextHolder.getRequestAttributes().removeAttribute(Attribute.KEY, RequestAttributes.SCOPE_SESSION);
//    }
}
