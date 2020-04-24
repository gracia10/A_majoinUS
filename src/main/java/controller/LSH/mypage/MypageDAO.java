package controller.LSH.mypage;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.DTO.Todo_listDTO;

@Repository
public class MypageDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<Todo_listDTO> getTodo(String mapper,String id){
		return sqlSession.selectList(mapper,id);
	}
	
	public int insertTodo(String mapper,Todo_listDTO dto){
		return sqlSession.update(mapper,dto);
	}
	
	public int deleteTodo(String mapper,List<String> num){
		return sqlSession.delete(mapper,num);
	}

	public int updateFin(String mapper,String dto){
		return sqlSession.update(mapper,dto);
	}

	public int deleteFin(String mapper,String dto){
		return sqlSession.update(mapper,dto);
	}
	
}
