package controller.LSH.mypage;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import project.DTO.Todo_listDTO;
import utils.CommonUtils;

@Controller
@RequestMapping("/aus")
public class MypageController {

	@Autowired
	private MypageService service;
	
	@GetMapping("/MyPageMain")
	public String getMypage(Model model){
		
		String receiver =(String) CommonUtils.getAttribute(CommonUtils.id);
		
		Map<String,List> map = service.getMypage(receiver);
		map.forEach((k,v)-> model.addAttribute(k,v));
		
		return "LSH/Mypage";
	}
	
	@PostMapping("/insertTodo")
	public void insertTodo(Todo_listDTO dto){
		service.insertTodo(dto);
	}
	
	@PostMapping("/Fin")
	public void Fin(String todo_num,String status){
		if(status.equals("추가")) {
			service.updateFin(todo_num);
		}else {
			service.deleteFin(todo_num);
		}
	}
	
	@PostMapping("/deleteTodo")
	public void deleteTodo(@RequestParam(value="todo_nums[]") List<String> todo_nums){
		service.deleteTodo(todo_nums);
	}

	
}