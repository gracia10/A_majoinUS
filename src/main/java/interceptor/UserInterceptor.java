package interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import controller.LSH.exceptor.AuthenticationException;
import controller.LSH.exceptor.AuthorizationException;

public class UserInterceptor extends HandlerInterceptorAdapter {

	private static Logger logger = LoggerFactory.getLogger(UserInterceptor.class);
	private final static String adminId = "amajoinus@gmail.com";

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		if (handler instanceof HandlerMethod == false) {
			return super.preHandle(request, response, handler);
		}

		HandlerMethod hm = (HandlerMethod) handler;
		String id = (String) request.getSession().getAttribute("id");
		
		if(id == null && !isAnnotationPresent(hm,NoLoginCheck.class)) {
			throw new AuthenticationException("로그인 정보를 잃었습니다");
		}
		
		if(isAnnotationPresent(hm,AdminOnly.class) && !id.equals(adminId)) {
			throw new AuthorizationException("접근 권한이 없습니다");
		}
		
		return super.preHandle(request, response, handler);
	}

//	private boolean isAjaxRequest(HttpServletRequest req) {
//		return ("true".equals(req.getHeader("AJAX"))? true : false);
//	}
	public boolean isAnnotationPresent(HandlerMethod hm, Class name) {
		return hm.getMethod().getDeclaringClass().isAnnotationPresent(name);
	}
}
