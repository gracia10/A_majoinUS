package controller.LSH.search;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import controller.LSH.search.user.ResultDTO;
import project.DTO.AlarmDTO;
import project.DTO.IssueDTO;
import project.DTO.PortfolioDTO;
import utils.CommonUtils;

@Service
@Transactional
public class SearchCommonService {
	
	@Autowired
	private SearchCommonDAO dao;
	
	public Map<String,Object> getCategory(){
		Map<String,Object> map = new HashMap<String, Object>();
		List<String> FJL1 = dao.getCategory1("LSH_AUS.select1",CommonUtils.JOB);
		List<String> FLL1 = dao.getCategory1("LSH_AUS.select1",CommonUtils.LOCAL);
		map.put("FJL1", FJL1);
		map.put("FLL1", FLL1);
		map.put("FJL2", getLevel2(FJL1.get(0)));
		map.put("FLL2", getLevel2(FLL1.get(0)));
		
		return map;
	}
	
	public List<String> getLevel2(String level1){
		List<String> list = dao.getCategory2("LSH_AUS.select2",level1);
		return list;
	}
	
	public Map<String,Object> getMy_fav(String id){
		Map<String,Object> map= new HashMap<String,Object>();
		ResultDTO dto = dao.getMy_fav("LSH_AUS.getMy_fav",id);
		
		map.put("job", Arrays.asList(dto.getF_cate().split(", ")));
		map.put("local", Arrays.asList(dto.getF_loc().split(", ")));
		map.put("id", id);
		
		return map;
	}
	
	public int follow(Map<String,Object> m,String status){
		
		int x = 0;
		if(status.equals("add")) {
			x = dao.map_insert("LSH_AUS.follow", m);
			m.put("num", 1);
		}else {
			x = dao.map_delete("LSH_AUS.unfollow", m);
			m.put("num", -1);
		}
		x = dao.map_update("LSH_AUS.follow_update", m);
		return x;
	}
	
	public int issue(IssueDTO dto){
		int count = dao.check_issue("LSH_AUS.check_issue",dto);
		
		if(count<3) {
			dao.insert_issue("LSH_AUS.insert_issue",dto);
			count = dao.count_issue("LSH_AUS.count_issue",dto);
			
			if(count>10) {
				dao.update_black("LSH_AUS.update_black",dto.getIssue_id());
			}
		}else {
			count = -1;
		}
		return count;
	}
	
	public int insert_Message(AlarmDTO dto){
		int x = dao.insert_Message("LSH_AUS.insert_A", dto);
		return x;
	}
	
	public Map<String, Object> get_project_profile(Map<String, Object> param){
		if(param.containsKey("view_count") && (boolean)param.get("view_count")) {
			update_view(new String[]{"project",(String)param.get("pj_num")});
		}
		
		Map<String,Object> map = dao.get_project_profile("LSH_AUS.getProjectRoom",(String)param.get("pj_num"));
		
		map.replace("START_D", map.get("START_D").toString().split(" ")[0]);
		map.replace("END_D", map.get("END_D").toString().split(" ")[0]);
		if(map.get("END_D").toString().split("-")[0].equals("2099")) {
			map.replace("END_D", "무기한");
		}
		return map;
	}
		
	public Map<String,Object> get_user_profile(Map<String,Object> param){
		List<PortfolioDTO> port =  new ArrayList<PortfolioDTO>();		
		HashSet<String> count = new HashSet<String>();
		HashSet<String> review = new HashSet<String>();
		Map<String,Object> map = new HashMap<String,Object>();
		
		if(param.containsKey("view_count") && (boolean)param.get("view_count")) {
			update_view(new String[]{"user",(String)param.get("id")});
		}
		
		List<ProfileDTO> x = dao.getProfile("LSH_AUS.getProfile", param);
		
		for(ProfileDTO m : x) {
			if(m.getPort_num() != 0 && !count.contains(m.getPort_num()+"")) {
				port.add(new PortfolioDTO(m.getPort_num(),m.getSubject(),m.getStart_d(),m.getEnd_d(),m.getP_private()));
				count.add(""+m.getPort_num());
			}
			if(m.getReview_content() != null && !review.contains(m.getReview_content())){
				review.add(m.getReview_content());					
			}
		}
		
		map.put("profile", x.get(0));
		map.put("port", port);
		map.put("review", review);
		
		return map;
	}
	
	public void update_view(String[] arr){
		Map<String,Object> m = new HashMap<String,Object>();
		
		if(arr[0].equals("user")) {
			
			m.put("what", arr[1]);
			m.put("colum", "mem_view");
			m.put("table", "member");
			m.put("where", "id");

		}else if(arr[0].equals("project")) {
			
			m.put("what", arr[1]);
			m.put("colum", "pj_view");
			m.put("table", "projectroom");
			m.put("where", "pj_num");
		}

		dao.update_view("LSH_AUS.update_view",m);
	}
	
}
