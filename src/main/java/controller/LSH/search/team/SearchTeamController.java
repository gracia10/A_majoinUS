package controller.LSH.search.team;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import controller.LSH.search.team.dto.SearchTeamDTO;
import controller.LSH.search.user.dto.PagingDTO;
import utils.CommonUtils;

@Controller
@RequestMapping("/aus")
public class SearchTeamController {
	
	@Autowired	
	private SearchTeamService service;
	
	@GetMapping("/SearchTeamForm")
	public String getSearchTeam(@ModelAttribute("command") SearchTeamDTO dto,Model model) {
		Map<String,Object> map = service.getSearchTeam(dto, CommonUtils.getUserId());
		map.forEach((k,v)-> model.addAttribute(k,v));
		return "LSH/SearchTeam"; 
	}
	
	@GetMapping("/teamSort")
	public @ResponseBody PagingDTO sort(SearchTeamDTO dto,int pageNum) throws ParseException{
		Date today = new Date();
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
		return pdto;
	}


	@PostMapping("/favorite")
	public @ResponseBody int favorite(int pj_num,String login_id,String status){
		int result = service.favorite(pj_num,login_id,status);
		return result;
	}
	
}
