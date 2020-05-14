package controller.LSH.search;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import project.DTO.AlarmDTO;
import project.DTO.IssueDTO;

@Transactional
public interface SearchCommonService {
	
	public Map<String,Object> getCategory();
	public List<String> getLevel2(String level1);
	public Map<String,Object> getMy_fav(String id);
	public int follow(Map<String,Object> m,String status);
	public int issue(IssueDTO dto);
	public int insert_Message(AlarmDTO dto);
	public Map<String, Object> get_project_profile(Map<String, Object> param);
	public Map<String,Object> get_user_profile(Map<String,Object> param);
	public void update_view(String[] arr);	
}
