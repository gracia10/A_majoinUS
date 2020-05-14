package controller.LSH.search.team;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import controller.LSH.search.team.dto.ResultTeamDTO;
import controller.LSH.search.team.dto.SearchTeamDTO;
import controller.LSH.search.user.dto.PagingDTO;
import project.DTO.ProjectroomDTO;

@Transactional
public interface SearchTeamService{
	
	public Map<String,Object> getSearchTeam(SearchTeamDTO dto,String id);
	public List<ResultTeamDTO> getRecomendTeam(String id);
	public int favorite(int pj_num,String id,String status);
	public PagingDTO paging(SearchTeamDTO dto,int pageNum);
	public List<ProjectroomDTO> getCart(String id);

}
