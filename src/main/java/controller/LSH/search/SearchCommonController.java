package controller.LSH.search;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.sf.json.JSONObject;
import project.DTO.IssueDTO;

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
	
	@RequestMapping(value="/UserProfile",method=RequestMethod.GET)
	public void profile(String id,HttpServletRequest req,HttpServletResponse resp) throws Exception{
		
		String login_id = req.getSession().getAttribute("id").toString();
		boolean accessCheck = req.getHeader("referer").contains("SearchUserForm");
		
		Map<String, Object> param = new HashMap<String, Object>();

		if(accessCheck && !login_id.equals("amajoinus@gmail.com")) {
			param.put("view_count", true);
		}
		
		param.put("id", id);
		param.put("login_id", login_id);
		Map<String,Object> x = service.get_user_profile(param);

		
		JSONObject jso = new JSONObject();
		jso.put("x", x);
		PrintWriter out = resp.getWriter();
		out.print(jso);
	}

	
	@RequestMapping(value="/follow",method=RequestMethod.POST)
	public void follow(String id,String login_id,String status,HttpServletResponse resp) throws Exception{
		resp.setContentType("text/html;charset=utf-8");
		int result = service.follow(login_id, id, status);
	}
	
	@RequestMapping(value="/issue",method=RequestMethod.POST)
	public void issue(String id,String login_id,@RequestParam(defaultValue="0")int pj_num,String is_content,HttpServletResponse resp) throws Exception{
		resp.setContentType("text/html;charset=utf-8");

		
		int result = service.issue(new IssueDTO(login_id,id,pj_num,is_content));
		
		JSONObject jso = new JSONObject();
		jso.put("x", result);
		PrintWriter out = resp.getWriter();
		out.print(jso);
	}
	

	@PostMapping("/ProjectProfile")
	public void profile(String pj_num,HttpServletResponse resp,HttpServletRequest req) throws Exception{
		
		boolean accessCheck = req.getHeader("referer").contains("SearchTeamForm");
		Map<String, Object> param = new HashMap<String, Object>();
		
		if(accessCheck && !req.getSession().getAttribute("id").toString().equals("amajoinus@gmail.com")) {
			param.put("view_count", true);
		}
		
		param.put("pj_num", pj_num);
		Map<String, Object> x = service.get_project_profile(param);
		
		JSONObject jso = new JSONObject();
		jso.put("x", x);
		PrintWriter out = resp.getWriter();
		out.print(jso);
	}
	
}


