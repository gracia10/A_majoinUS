package controller.LSH.mypage;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import dao.JEJ;
import project.DTO.Todo_listDTO;

@Service
public class MypageServiceImpl implements MypageService {

	@Autowired
	private JEJ dao;
	
	@Autowired
	private MypageDAO mypageDAO;
	
	public Map<String,List> getMypage(String receiver) {
		Map<String,List> map = new HashMap<String,List>();
		
		map.put("ongoing_list", dao.ongoing_getListData(receiver));
		map.put("projectApplyAlarm", dao.getProjectApplyAlarm(receiver, "참가"));
		map.put("projectProposalAlarm", dao.getProjectApplyAlarm(receiver, "초대"));
		map.put("todo", getTodo(receiver));
		
		return map;
	} 
	
	public List<Todo_listDTO> getTodo(String id){
		List<Todo_listDTO> list = mypageDAO.getTodo("LSH_AUS.getTodo",id);
		return list;
	}
	
	public int insertTodo(Todo_listDTO dto){
		int x =  mypageDAO.insertTodo("LSH_AUS.insertTodo",dto);
		return x;
	}

	public int updateFin(String num){
		int x =  mypageDAO.updateFin("LSH_AUS.updateFin",num);
		return x;
	}
	
	public int deleteFin(String num){
		int x = mypageDAO.deleteFin("LSH_AUS.deleteFin",num);
		return x;
	}
	
	public int deleteTodo(List<String> num){
		int x = mypageDAO.deleteTodo("LSH_AUS.deleteTodo",num);
		return x;
	}

}
