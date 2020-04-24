package controller.LSH.mypage;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import project.DTO.Todo_listDTO;

@Service
public class MypageService {

	@Autowired
	private MypageDAO dao;
	
	public List<Todo_listDTO> getTodo(String id){
		List<Todo_listDTO> list = dao.getTodo("LSH_AUS.getTodo",id);
		return list;
	}
	
	public int insertTodo(Todo_listDTO dto){
		int x =  dao.insertTodo("LSH_AUS.insertTodo",dto);
		return x;
	}

	public int updateFin(String num){
		int x =  dao.updateFin("LSH_AUS.updateFin",num);
		return x;
	}
	
	public int deleteFin(String num){
		int x = dao.deleteFin("LSH_AUS.deleteFin",num);
		return x;
	}
	
	public int deleteTodo(List<String> num){
		int x = dao.deleteTodo("LSH_AUS.deleteTodo",num);
		return x;
	}

}
