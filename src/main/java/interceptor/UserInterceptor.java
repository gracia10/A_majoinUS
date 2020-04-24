package interceptor;

import java.nio.file.AccessDeniedException;

import javax.security.sasl.AuthenticationException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;


public class UserInterceptor extends HandlerInterceptorAdapter{

	private static Logger logger = LoggerFactory.getLogger(UserInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)throws Exception {
		
		String id = (String) request.getSession().getAttribute("id");

		HandlerMethod handlerMethod = (HandlerMethod)handler;
		NoLoginCheck noCheck = handlerMethod.getMethod().getDeclaringClass().getAnnotation(NoLoginCheck.class);

		if(noCheck == null) {
			
			if(id.isEmpty()) {
				logger.info("[sessionCheck] {}",request.getSession().toString());
				throw new Exception("로그인 정보가 없습니다 다시 접속해 주세요");			
			}
			
//			if(!id.equals("amajoinus@gmail.com")){
//				logger.info("[authenticateCheck] {}",id);		
//				throw new Exception("접근권한이 없습니다");				
//			}
		}
		return true;
	}

	private boolean isAjaxRequest(HttpServletRequest req) {
		return ("true".equals(req.getHeader("AJAX"))? true : false);
	}
}
