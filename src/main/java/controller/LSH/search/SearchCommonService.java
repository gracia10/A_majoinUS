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

import controller.LSH.DTO.ProfileDTO;
import controller.LSH.DTO.ResultDTO;
import project.DTO.IssueDTO;
import project.DTO.PortfolioDTO;

@Service
@Transactional
public class SearchCommonService {
	
	@Autowired
	private SearchCommonDAO dao;
	
	public List<String> getLevel1(String col){
		List<String> list  = dao.getCategory1("LSH_AUS.select1",col);
		return list;
	}

	public List<String> getLevel2(String col){
		List<String> list = dao.getCategory1("LSH_AUS.select2",col);
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
	
	public int follow(String id, String friend_id,String status){
		Map<String,Object> m = new HashMap<String,Object>();
		m.put("id", id);
		m.put("friend_id", friend_id);
		
		int x = 0;
		try {
			if(status.equals("add")) {
				x = dao.map_insert("LSH_AUS.follow", m);
				m.put("num", 1);
			}else {
				x = dao.map_delete("LSH_AUS.unfollow", m);
				m.put("num", -1);
			}
			x = dao.map_update("LSH_AUS.follow_update", m);
		}catch (Exception e) {
			System.out.println("[에러] 팔로우 서비스 실패 ::"+e.toString());
		}
		return x;
	}
	
	public int issue(IssueDTO dto){
		
		int count = 0;
		
		try {
			count = dao.check_issue("LSH_AUS.check_issue",dto);
			
			if(count<3) {
				dao.insert_issue("LSH_AUS.insert_issue",dto);
				count = dao.count_issue("LSH_AUS.count_issue",dto);
				System.out.println("[누적신고횟수]"+count);
				
				if(count>10) {
					System.out.println("[블랙리스트 추가]");
					dao.update_black("LSH_AUS.update_black",dto.getIssue_id());
				}
			}else {
				count = -1;
			}
			
		}catch (Exception e) {
			System.out.println("[에러] 신고 서비스 실패 ::"+e.toString());
		}
		return count;
	}
	
	@Transactional
	public Map<String, Object> get_project_profile(Map<String, Object> param) throws Exception {
		Map<String,Object> map = new HashMap<String,Object>();

		if(param.containsKey("view_count") && (boolean)param.get("view_count")) {
			update_view(new String[]{"project",(String)param.get("pj_num")});
		}
		
		try {
			map = dao.get_project_profile("LSH_AUS.getProjectRoom",(String)param.get("pj_num"));
			
			map.replace("START_D", map.get("START_D").toString().split(" ")[0]);
			map.replace("END_D", map.get("END_D").toString().split(" ")[0]);
			if(map.get("END_D").toString().split("-")[0].equals("2099")) {
				map.replace("END_D", "무기한");
			}
			
			
		}catch (Exception e) {
			System.out.println("[에러] 프로젝트룸 서비스 실패 ::"+e.toString());
			throw new Exception();
		} 
		return map;
	}
		
	@Transactional
	public Map<String,Object> get_user_profile(Map<String,Object> param) throws Exception{
		List<ProfileDTO> x = null;
		
		List<PortfolioDTO> port =  new ArrayList<PortfolioDTO>();		
		HashSet<String> count = new HashSet<String>();
		HashSet<String> review = new HashSet<String>();
		
		Map<String,Object> map = new HashMap<String,Object>();
		
		if(param.containsKey("view_count") && (boolean)param.get("view_count")) {
			update_view(new String[]{"user",(String)param.get("id")});
		}
		
		
		try {
			x = dao.getProfile("LSH_AUS.getProfile", param);
			
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
			

		}catch (Exception e) {
			System.out.println("[에러] 프로필 가져오기 서비스 실패 ::"+e.toString());
			throw new Exception();
		}
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
