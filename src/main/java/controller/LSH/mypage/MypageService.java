package controller.LSH.mypage;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

import project.DTO.Todo_listDTO;

@Transactional
public interface MypageService {

	public Map<String,List> getMypage(String receiver);
	public List<Todo_listDTO> getTodo(String id);
	public int insertTodo(Todo_listDTO dto);
	public int updateFin(String num);
	public int deleteFin(String num);
	public int deleteTodo(List<String> num);

}
