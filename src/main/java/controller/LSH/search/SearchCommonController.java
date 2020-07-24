package controller.LSH.search;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import project.DTO.AlarmDTO;
import project.DTO.IssueDTO;
import utils.CommonUtils;

@Controller
@RequestMapping("/aus")
public class SearchCommonController {
	
	@Autowired
	private SearchCommonService service;
	
	@GetMapping("/category")
	public @ResponseBody Map<String,Object> getCategory(){
		Map<String,Object> map = service.getCategory();
		return map;
	}
	
	@GetMapping("/category/{level1}")
	public @ResponseBody List<String> getLevel2(@PathVariable String level1){
		List<String> list = service.getLevel2(level1);
		return list;
	}
	
	@GetMapping("/UserProfile")
	public @ResponseBody Map<String, Object> getUserProfile(String id,HttpServletRequest req){
		String login_id = CommonUtils.getUserId();
		Map<String, Object> param = new HashMap<String, Object>();
		if(req.getHeader("referer").contains("SearchUserForm") && !login_id.equals(CommonUtils.ADMIN)) {
			param.put("view_count", true);
		}
		param.put("id", id);
		param.put("login_id", login_id);
		Map<String,Object> result = service.get_user_profile(param);
		return result;
	}
	
	@GetMapping("/ProjectProfile")
	public @ResponseBody Map<String, Object> getProjectProfile(String pj_num,HttpServletRequest req){
		boolean accessCheck = req.getHeader("referer").contains("SearchTeamForm");
		Map<String, Object> param = new HashMap<String, Object>();
		if(accessCheck && !CommonUtils.getUserId().equals(CommonUtils.ADMIN)) {
			param.put("view_count", true);
		}
		param.put("pj_num", pj_num);
		
		Map<String, Object> x = service.get_project_profile(param);
		return x;
	}
	
	@PostMapping("/follow")
	public @ResponseBody int follow(String id,String login_id,String status){
		Map<String,Object> m = new HashMap<String,Object>();
		m.put("id", login_id);
		m.put("friend_id", id);
		
		int result = service.follow(m, status);
		return result;
	}
	
	@PostMapping("/issue")
	public @ResponseBody int issue(String id,String login_id,@RequestParam(defaultValue="0")int pj_num,String is_content){
		int result = service.issue(new IssueDTO(login_id,id,pj_num,is_content));
		return result;
	}
	
	@PostMapping("/insert_Message")
	public @ResponseBody int insert_Message(AlarmDTO alarm){
		int result = service.insert_Message(alarm);
		return result;
	}
	
	
}


