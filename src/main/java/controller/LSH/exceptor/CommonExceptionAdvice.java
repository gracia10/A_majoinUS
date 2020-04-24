package controller.LSH.exceptor;


import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;


@ControllerAdvice
public class CommonExceptionAdvice {

	private static final Logger logger = LoggerFactory.getLogger(CommonExceptionAdvice.class);
	
	@ExceptionHandler(Exception.class)		
	public ModelAndView commonException(HttpServletRequest req, Exception e) {

		logger.error("Exception Occure {}", e);

		ModelAndView mav = new ModelAndView();
		mav.addObject("exception",e);
		mav.setViewName("LSH/error");
		
		return mav;
	}
	
}
