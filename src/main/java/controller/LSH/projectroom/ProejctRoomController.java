package controller.LSH.projectroom;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import utils.CommonUtils;

@Controller
@RequestMapping("/aus/ProejctRoom")
public class ProejctRoomController {
	
	@Autowired
	private ProjectRoomService service;
	
	@GetMapping(value="/Main")
	public String getMain(@RequestParam(value="pj_Num") int pj_Num, Model model) {
		String id= (String) CommonUtils.getAttribute(CommonUtils.ID);
		Map<String,Object> map = service.getMain(id, pj_Num);
		map.forEach((k,v)-> model.addAttribute(k,v));
		
		return "LSH/ProjectRoom";
	}
	
	@PostMapping(value="/transfer")
	public String transfer(@RequestParam(value="info") String memberId,@RequestParam(value="pj_Num") int pj_Num) {
		int x = service.updateLeader(memberId, pj_Num);
		return "redirect:Main?pj_Num="+pj_Num;
	}
	
	@PostMapping(value="/kick")
	public String kick(@RequestParam(value="info") int pjm_num,@RequestParam(value="pj_Num") int pj_Num) {
		int x = service.kick(pjm_num);
		return "redirect:Main?pj_Num="+pj_Num;
	}
}