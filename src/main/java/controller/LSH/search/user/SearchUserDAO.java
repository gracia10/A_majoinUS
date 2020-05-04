package controller.LSH.search.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import controller.LSH.DTO.ResultDTO;
import controller.LSH.DTO.SearchDTO;
import project.DTO.AlarmDTO;

@Repository
public class SearchUserDAO{

	@Autowired
	private SqlSession sqlSession;

	public List<ResultDTO> recommend_User(String mapper,Map<String,Object> map){
		List<ResultDTO> list = sqlSession.selectList(mapper,map);
		return list;		
	}
	
	public int getNumber(String mapper,SearchDTO dto){
		int result = sqlSession.selectOne(mapper,dto);
		return result;
	}
	
	public List<ResultDTO> getResult(String mapper,SearchDTO dto){
		List<ResultDTO> result = sqlSession.selectList(mapper,dto);
		return result;
	}

	public List<HashMap<String,Object>> getMyProject(String mapper,String id){
		List<HashMap<String,Object>> list = sqlSession.selectList(mapper,id);
		return list;
	}
	
	public int insert_Message(String mapper,AlarmDTO dto){
		int x = sqlSession.insert(mapper,dto);
		return x;
	}
}
