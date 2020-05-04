package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import exception.AuthenticationException;
import exception.AuthorizationException;

public class UserInterceptor extends HandlerInterceptorAdapter {

	private static Logger logger = LoggerFactory.getLogger(UserInterceptor.class);
	
	private final static String adminId = "amajoinus@gmail.com";

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		
		logger.info("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
		
		
		if (handler instanceof HandlerMethod == false) {
			return super.preHandle(request, response, handler);
		}

		HandlerMethod hm = (HandlerMethod) handler;
		String id = (String) request.getSession().getAttribute("id");
		
		if(id == null && !isAnnotationPresent(hm,NoLoginCheck.class)) {
			throw new AuthenticationException();
		}
		
		if(isAnnotationPresent(hm,AdminOnly.class) && !id.equals(adminId)) {
			throw new AuthorizationException();
		}
		
		return super.preHandle(request, response, handler);
	}

	public boolean isAnnotationPresent(HandlerMethod hm, Class c) {
		return hm.getMethod().getDeclaringClass().isAnnotationPresent(c);
	}
}
