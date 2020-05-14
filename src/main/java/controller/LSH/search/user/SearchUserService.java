package controller.LSH.search.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import controller.LSH.search.user.dto.PagingDTO;
import controller.LSH.search.user.dto.ResultDTO;
import controller.LSH.search.user.dto.SearchDTO;

@Transactional
public interface SearchUserService{

	public Map<String,Object> getSearchUser(String id, SearchDTO dto);
	public List<ResultDTO> recommend_User(String id);
	public List<HashMap<String,Object>> getMyProject(String id);
	public PagingDTO paging(SearchDTO dto,int pageNum);	
}
