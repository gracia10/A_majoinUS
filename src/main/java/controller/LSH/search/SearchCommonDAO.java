package controller.LSH.search;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import controller.LSH.search.user.dto.ResultDTO;
import project.DTO.AlarmDTO;
import project.DTO.IssueDTO;

@Repository
public class SearchCommonDAO {

	@Autowired
	private SqlSession sqlSession;

	public List<String> getCategory1(String mapper, String col) {
		List<String> cate1 = sqlSession.selectList(mapper, col);
		return cate1;
	}

	public List<String> getCategory2(String mapper, String col) {
		List<String> cate2 = sqlSession.selectList(mapper, col);
		return cate2;
	}

	public ResultDTO getMy_fav(String mapper, String id) {
		ResultDTO x = sqlSession.selectOne(mapper, id);
		return x;
	}
	//
	public int map_insert(String mapper, Map<String, Object> m) {
		int x = sqlSession.insert(mapper, m);
		return x;
	}

	public int map_delete(String mapper, Map<String, Object> m) {
		int x = sqlSession.delete(mapper, m);
		return x;
	}

	public int map_update(String mapper, Map<String, Object> m) {
		int x = sqlSession.update(mapper, m);
		return x;
	}

	// 유저 프로필정보 //
	public List<ProfileDTO> getProfile(String mapper, Map<String, Object> ids) {
		List<ProfileDTO> x = sqlSession.selectList(mapper, ids);
		return x;
	}

	// 프로젝트룸 정보 //
	public Map<String, Object> get_project_profile(String mapper, String pj_num) {
		HashMap<String, Object> x = sqlSession.selectOne(mapper, pj_num);
		return x;
	}

	public int check_issue(String mapper, IssueDTO dto) {
		int x = sqlSession.selectOne(mapper, dto);
		return x;
	}

	public int insert_issue(String mapper, IssueDTO dto) {
		int x = sqlSession.insert(mapper, dto);
		return x;
	}

	public int count_issue(String mapper, IssueDTO dto) {
		int x = sqlSession.selectOne(mapper, dto);
		return x;
	}

	public int update_black(String mapper, String id) {
		int x = sqlSession.update(mapper, id);
		return x;
	}
	//
	public int insert_Message(String mapper,AlarmDTO dto){
		int x = sqlSession.insert(mapper,dto);
		return x;
	}

	// 뷰 업데이트 //
	public int update_view(String mapper, Map<String, Object> m) {
		int x = sqlSession.update(mapper, m);
		return x;
	}
}
