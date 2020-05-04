package controller.LSH.projectroom;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ProjectRoomDAO{
	
	@Autowired
	private SqlSession sqlSession;
	
	public List<Map<String,Object>> getProgress(String mapper,int n){
		return sqlSession.selectList(mapper,n);
	}	
	
	public int updateLeader(String mapper,Map<String,Object> m) {
		return sqlSession.update(mapper,m);
	}

    public int kick(String mapper,int pjm_mem) {
    	return sqlSession.delete(mapper,pjm_mem);
	}
	
}
