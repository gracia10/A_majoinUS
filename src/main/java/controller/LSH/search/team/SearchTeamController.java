package controller.LSH.search.team;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import controller.LSH.DTO.PagingDTO;
import controller.LSH.DTO.ResultTeamDTO;
import controller.LSH.DTO.SearchTeamDTO;
import net.sf.json.JSONObject;
import project.DTO.ProjectroomDTO;
import utils.CommonUtils;

@Controller
@RequestMapping("/aus")
public class SearchTeamController {
	
	@Autowired	
	private SearchTeamService service;
	
	@GetMapping("/SearchTeamForm")
	public String getSearchTeam(@ModelAttribute("command") SearchTeamDTO dto,Model model) {
		Map<String,Object> map = service.getSearchTeam(CommonUtils.getUserId());
		map.forEach((k,v)-> model.addAttribute(k,v));
		return "LSH/SearchTeam"; 
	}
	
	@PostMapping("/SearchTeamForm")
	public String post(@ModelAttribute("command") SearchTeamDTO dto,Model model) {
		Map<String,Object> map = service.postSearchTeam(dto, CommonUtils.getUserId());
		map.forEach((k,v)-> model.addAttribute(k,v));
		return "LSH/SearchTeam";
	}
	
	@PostMapping("/TeamSort")
	public void sort(SearchTeamDTO dto,HttpServletResponse resp, int pageNum) throws Exception{

		Date today = new Date();
		String str = "";
		
		if(dto.getChecking().equals("y")) {
			if(dto.getStart_d().isEmpty()) {
				dto.setStart_d(new SimpleDateFormat("yyyy-MM-dd").format(today));
			}else {
				Date date = new SimpleDateFormat("yyyy-MM-dd").parse(dto.getStart_d());
				if(date.before(today)) {
					dto.setStart_d(new SimpleDateFormat("yyyy-MM-dd").format(today));
				}			
			}
		}
		
		PagingDTO pdto = service.paging(dto,pageNum);
		JSONObject jso = new JSONObject();
		jso.put("pdto", pdto);
		PrintWriter out = resp.getWriter();
		out.print(jso);
	}


	@PostMapping("/favorite")
	public void favorite(int pj_num,String login_id,String status){
		int result = service.favorite(pj_num,login_id,status);
	}
	
}
