package controller.LSH.search.user;

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
import org.springframework.web.bind.annotation.ResponseBody;

import exception.BadRequestException;
import project.DTO.AlarmDTO;
import utils.CommonUtils;

@Controller
@RequestMapping("/aus")
public class SearchUserController {
	
	@Autowired
	private SearchUserService service;
	
	@GetMapping("/SearchUserForm")
	public String getSearchUser(@ModelAttribute("command") SearchDTO dto,Model model) {
		Map<String,Object> map = service.getSearchUser(CommonUtils.getUserId(),dto);
		map.forEach((k,v)-> model.addAttribute(k,v));
		return "LSH/SearchUser";
	}
	
	@GetMapping("/userSort")
	public @ResponseBody PagingDTO sort(SearchDTO dto,@RequestParam(defaultValue="0")int pageNum){
		PagingDTO pdto = service.paging(dto,pageNum);
		return pdto;
	}
	
	@PostMapping("/show")
	public @ResponseBody List<HashMap<String,Object>> plus_member(String id){
		List<HashMap<String,Object>> list = service.getMyProject(id);
		return list;
	}
}


