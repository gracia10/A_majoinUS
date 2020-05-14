package controller.LSH.search.team;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import controller.LSH.search.SearchCommonDAO;
import controller.LSH.search.team.dto.ResultTeamDTO;
import controller.LSH.search.team.dto.SearchTeamDTO;
import project.DTO.ProjectroomDTO;

@Repository
public class SearchTeamDAO{

	@Autowired
	private SqlSession sqlSession;

	public List<ProjectroomDTO> getCart(String mapper,String id) {
		List<ProjectroomDTO> x = sqlSession.selectList(mapper,id);
		return x;
	}
	
	public List<ResultTeamDTO> recommend_Team(String mapper,Map<String,Object> map){
		List<ResultTeamDTO> list = sqlSession.selectList(mapper,map);
		return list;		
	}
	
	public int getTeamNumber(String mapper,SearchTeamDTO dto){
		int result = sqlSession.selectOne(mapper,dto);
		return result;
	}
	
	public List<ResultTeamDTO> getTeamResult(String mapper,SearchTeamDTO dto){
		List<ResultTeamDTO> result = sqlSession.selectList(mapper,dto);
		return result;
	}
	
	public int map_insert(String mapper,Map<String,Object> m){
		int x = sqlSession.insert(mapper,m);
		return x;
	}
	
	public int map_delete(String mapper,Map<String,Object> m){
		int x = sqlSession.delete(mapper,m);
		return x;
	}
}
