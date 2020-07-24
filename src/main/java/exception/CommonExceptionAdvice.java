package exception;


import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MissingPathVariableException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice
public class CommonExceptionAdvice {
	
	private static final Logger logger = LoggerFactory.getLogger(CommonExceptionAdvice.class);

    @ExceptionHandler({
    	MethodArgumentTypeMismatchException.class, 
    	MissingServletRequestParameterException.class, 
    	MissingPathVariableException.class,
    	BadRequestException.class})
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    protected String badRequestException(Exception e, Model model,HttpServletRequest req){
    	logger.error("BadRequestException Occure {}", e);
		model.addAttribute("message", ErrorCode.BAD_REQUEST.getMessage());
		return "LSH/error";
    }
    
    @ExceptionHandler(HttpRequestMethodNotSupportedException.class)
    @ResponseStatus(HttpStatus.METHOD_NOT_ALLOWED)
    protected String handleHttpRequestMethodNotSupportedException(HttpRequestMethodNotSupportedException e, Model model) {
    	logger.error("HttpRequestMethodNotSupportedException", e);
		model.addAttribute("message", ErrorCode.METHOD_NOT_ALLOWED.getMessage());
		return "LSH/error";
    }
    
    @ExceptionHandler(NoHandlerFoundException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    protected String noHandlerFoundException(NoHandlerFoundException e, Model model){
    	logger.error("NoHandlerFoundException Occure {}", e.getMessage());
    	model.addAttribute("message", ErrorCode.NOT_FOUND.getMessage());
    	return "LSH/error";
    }
	
	@ExceptionHandler(AuthenticationException.class)
	@ResponseStatus(HttpStatus.FORBIDDEN)
	protected String authenticationException(AuthenticationException e, Model model) {
		logger.error("AuthenticationException {}", e.getMessage());
		model.addAttribute("message",e.getMessage());
		return "LSH/error";
	}
	
	@ExceptionHandler(AuthorizationException.class)
	@ResponseStatus(HttpStatus.FORBIDDEN)
	protected String authorizationException(AuthorizationException e, Model model) {
		logger.error("AuthorizationException {}", e.getMessage());
		model.addAttribute("message",e.getMessage());
		return "LSH/error";
	}
	
	@ExceptionHandler(Exception.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	protected ModelAndView commonException(Exception e) {
		logger.error("Exception Occure {}", e);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("message",ErrorCode.INTERNAL_SERVER_ERROR.getMessage());
		mav.setViewName("LSH/error");
		return mav;
	}
	
}
