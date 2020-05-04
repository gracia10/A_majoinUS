package controller.LSH.search.user;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import controller.LSH.DTO.PagingDTO;
import controller.LSH.DTO.ResultDTO;
import controller.LSH.DTO.SearchDTO;
import controller.LSH.search.SearchCommonService;
import project.DTO.AlarmDTO;
import utils.CommonUtils;

@Service
@Transactional
public class SearchUserService{

	@Autowired
	private SearchUserDAO dao;
	
	@Autowired
	private SearchCommonService service;
	
	public List<ResultDTO> getSearchUser(String id){
		List<ResultDTO> Recomend_User = recommend_User(id);
		return Recomend_User;
	}
	
	public Map<String,Object> postSearchUser(String id, SearchDTO dto){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("recomend", recommend_User(id));
		result.put("pdto", paging(dto,0));
		return result;
	}
	
	public List<ResultDTO> recommend_User(String id){
		Map<String,Object> map = service.getMy_fav(id);
		List<ResultDTO> list = new ArrayList<ResultDTO>();
		
		if(id.equals(CommonUtils.admin)) {return list;}
		
		list = dao.recommend_User("LSH_AUS.recommend_User",map);
		int len = list.size();
		if(len <3) {
			for(int i = 0; i < 3-len; i+=1) {
				list.add(new ResultDTO());
			}
		}
		return list;
	}
	
	public List<HashMap<String,Object>> getMyProject(String id){
		List<HashMap<String,Object>> list = dao.getMyProject("LSH_AUS.myProject", id);
		return list;
	}
	
	public int insert_Message(AlarmDTO dto){
		int x = dao.insert_Message("LSH_AUS.insert_A", dto);
		return x;
	}
	
	
	public PagingDTO paging(SearchDTO dto,int pageNum) {
		if(pageNum == 0) { pageNum = 1;}

		int pageSize = 3;
		int pageBlock = 3;
		int startRow = (pageNum - 1) * pageSize + 1;
		int endRow = pageNum * pageSize;
		int rowCount = dao.getNumber("LSH_AUS.searchNumber",dto);
		int pageCount = (int) Math.ceil(rowCount/(double) pageSize);
		int endPage = (int) Math.ceil(pageNum/(double) pageBlock) * pageBlock;
		int startPage = (endPage - pageBlock) + 1;

		if(pageCount < endPage) {
			endPage = pageCount;
		}
		
//		System.out.print("::현재페이지"+pageNum+"::전체"+rowCount+"~첫글 번호"+startRow+"~끝글번호"+endRow);
//		System.out.println("::페이지수 "+pageCount+" ::시작페이지 "+startPage+" ::끝페이지 "+endPage);
		
		dto.setStartRow(startRow);
		dto.setEndRow(endRow);
		List<ResultDTO> list = dao.getResult("LSH_AUS.search",dto);
		
		return new PagingDTO(pageNum,rowCount,pageCount,startPage,endPage,list,pageBlock);
	}
	
}
