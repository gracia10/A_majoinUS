package controller.LSH.mypage;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import controller.LSH.exceptor.CommonExceptionAdvice;
import controller.PHE.ProjectAlarmListDTO;
import controller.PHE.ProjectListDTO;
import dao.JEJ;
import project.DTO.Todo_listDTO;

@Controller
@RequestMapping("/aus")
public class MypageController {

	
	private static final Logger logger = LoggerFactory.getLogger(MypageController.class);
	
	@Autowired
	private MypageService service;
	
	@Autowired
	private JEJ dao;
	
	@RequestMapping(value="/MyPageMain")
	@Transactional
	public String main(HttpSession session,Model model){
		
		session.removeAttribute("Dday");
		session.removeAttribute("pjm_num");
		String receiver =(String)session.getAttribute("id");
		
		String a_type = "참가";
		List<ProjectAlarmListDTO> projectApplyAlarm = dao.getProjectApplyAlarm(receiver, a_type);
		
		a_type="초대";
		List<ProjectAlarmListDTO> projectProposalAlarm = dao.getProjectApplyAlarm(receiver, a_type);
		
		
		//진행중인 프로젝트
		List<ProjectListDTO> ongoing_list = dao.ongoing_getListData(receiver);

		
		model.addAttribute("ongoing_list",ongoing_list);
		model.addAttribute("projectApplyAlarm_size", projectApplyAlarm.size());
		model.addAttribute("projectApplyAlarm", projectApplyAlarm);
		model.addAttribute("projectProposalAlarm_size", projectProposalAlarm.size());
		model.addAttribute("projectProposalAlarm", projectProposalAlarm);
		
		// LSH. getTodo
		model.addAttribute("todo",service.getTodo(receiver));
		
		return "LSH/Mypage";
	}
	
	@RequestMapping(value="/insertTodo")
	public void insertTodo(Todo_listDTO dto,HttpServletResponse resp) throws Exception{
		service.insertTodo(dto);
	}
	
	@RequestMapping(value="/Fin")
	public void Fin(String todo_num,String status,HttpServletResponse resp) throws Exception{
		if(status.equals("추가")) {
			service.updateFin(todo_num);
		}else {
			service.deleteFin(todo_num);
		}
	}
	
	@RequestMapping(value="/deleteTodo")
	public void deleteTodo(@RequestParam(value="todo_nums[]") List<String> todo_nums,HttpServletResponse resp) throws Exception{
		service.deleteTodo(todo_nums);
	}

	
}