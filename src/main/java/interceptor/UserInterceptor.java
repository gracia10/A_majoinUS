package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import exception.AuthenticationException;
import exception.AuthorizationException;
import utils.CommonUtils;

public class UserInterceptor extends HandlerInterceptorAdapter {

	private static Logger logger = LoggerFactory.getLogger(UserInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) 
			throws Exception {

		logger.info("UserInterceptor prehandle job start");
		
		if (handler instanceof HandlerMethod == false) {
			return super.preHandle(request, response, handler);
		}

		HandlerMethod hm = (HandlerMethod) handler;
		String id = CommonUtils.getUserId();
		
		if(id == null && !isAnnotationPresent(hm,NoLoginCheck.class)) {
			throw new AuthenticationException();
		}
		
		if(isAnnotationPresent(hm,AdminOnly.class) && !id.equals(CommonUtils.ADMIN)) {
			throw new AuthorizationException();
		}
		
		return super.preHandle(request, response, handler);
	}

	public boolean isAnnotationPresent(HandlerMethod hm, Class c) {
		return hm.getMethod().getDeclaringClass().isAnnotationPresent(c);
	}
}
