package controller.LSH.search.user;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import controller.LSH.DTO.PagingDTO;
import controller.LSH.DTO.ResultDTO;
import controller.LSH.DTO.SearchDTO;
import net.sf.json.JSONObject;
import project.DTO.AlarmDTO;
import utils.CommonUtils;

@Controller
@RequestMapping("/aus")
public class SearchUserController {
	
	@Autowired
	private SearchUserService service;
	
	@GetMapping("/SearchUserForm")
	public String getSearchUser(@ModelAttribute("command") SearchDTO dto,Model model) {	
		List<ResultDTO> recomend = service.getSearchUser(CommonUtils.getUserId()); 
		model.addAttribute("recomend",recomend);
		return "LSH/SearchUser";
	}
	
	@PostMapping("/SearchUserForm")
	public String postSearchUser(@ModelAttribute("command") SearchDTO dto,Model model) {
		Map<String,Object> map = service.postSearchUser(CommonUtils.getUserId(),dto);
		map.forEach((k,v)-> model.addAttribute(k,v));
		return "LSH/SearchUser";
	}
	
	@PostMapping("/UserSort")
	public void sort(SearchDTO dto,@RequestParam(defaultValue="0")int pageNum,HttpServletResponse resp) throws Exception{
		PagingDTO pdto = service.paging(dto,pageNum);
		JSONObject jso = new JSONObject();
		jso.put("pdto", pdto);
		PrintWriter out = resp.getWriter();
		out.print(jso);
	}
	
	@PostMapping("/show")
	public void plus_member(String id,HttpServletResponse resp) throws Exception{
		
		List<HashMap<String,Object>> list = service.getMyProject(id);
		JSONObject jso = new JSONObject();
		jso.put("mine", list);
		PrintWriter out = resp.getWriter();
		out.print(jso);
	}

	@RequestMapping(value="/insert_Message",method=RequestMethod.POST)
	public void insert_Message(AlarmDTO alarm,HttpServletResponse resp) throws Exception{
		int result = service.insert_Message(alarm);
	}
	
	



}


