package controller.LSH.search.team;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import controller.LSH.DTO.PagingDTO;
import controller.LSH.DTO.ResultTeamDTO;
import controller.LSH.DTO.SearchTeamDTO;
import controller.LSH.search.SearchCommonService;
import project.DTO.ProjectroomDTO;
import utils.CommonUtils;

@Service
@Transactional
public class SearchTeamService{
	
	@Autowired
	private SearchTeamDAO dao;
	
	@Autowired
	private SearchCommonService service;
	
	public Map<String,Object> getSearchTeam(String id){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("cart", getCart(id));
		result.put("recomend", getRecomendTeam(id));
		return result;
	}
	
	public List<ResultTeamDTO> getRecomendTeam(String id){
		Map<String,Object> map = service.getMy_fav(id);
		List<ResultTeamDTO> recomendList = new ArrayList<ResultTeamDTO>();
		if(id.equals(CommonUtils.admin)) {return recomendList;}
		
		recomendList = dao.recommend_Team("LSH_AUS.recommend_Team",map);
		int len = recomendList.size();
		if(len<3) {
			for(int i = 0; i < 3-len; i+=1) {
				recomendList.add(new ResultTeamDTO());
			}
		}
		return recomendList;
	}
	
	public Map<String,Object> postSearchTeam(SearchTeamDTO dto,String id){
		Map<String,Object> result = new HashMap<String,Object>();
		result.put("pdto", paging(dto,0));
		result.put("cart", getCart(id));
		result.put("recomend", getRecomendTeam(id));
		return result;
	}
	
	public int favorite(int pj_num,String id,String status){
		Map<String,Object> m = new HashMap<String,Object>();
		m.put("pj_num", pj_num);
		m.put("id",id);
		
		int x = 0;
		if(status.equals("add")) {
			x = dao.map_insert("LSH_AUS.star", m);
		}else {
			x = dao.map_delete("LSH_AUS.unstar", m);
		}
		return x;
	}
	
	
	public PagingDTO paging(SearchTeamDTO dto,int pageNum) {

		if(pageNum == 0) {
			pageNum = 1;
		}

		int pageSize = 4;
		int pageBlock = 3;
		
		int rowCount = dao.getTeamNumber("LSH_AUS.searchTeamNumber",dto);
		int pageCount = (int) Math.ceil(rowCount/(double) pageSize);
		
		if(pageNum > pageCount) {
			pageNum = 1;
		}
		
		int endPage = (int) Math.ceil(pageNum/(double) pageBlock) * pageBlock;
		int startPage = (endPage - pageBlock) + 1;

		if(pageCount < endPage) {
			endPage = pageCount;
		}
		
		int startRow = (pageNum - 1) * pageSize + 1;
		int endRow = pageNum * pageSize;
		
		dto.setStartRow(startRow);
		dto.setEndRow(endRow);
		List<ResultTeamDTO> list = dao.getTeamResult("LSH_AUS.searchTeam",dto);
		
		PagingDTO pdto = new PagingDTO(pageNum,rowCount,pageCount,startPage,endPage,list,pageBlock);
		
		return pdto;
	}
	
	public List<ProjectroomDTO> getCart(String id){
		List<ProjectroomDTO> list = dao.getCart("LSH_AUS.getCart",id);
		return list;	
	}

	

}
