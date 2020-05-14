package controller.LSH.projectroom;

import java.util.List;
import java.util.Map;

import org.springframework.transaction.annotation.Transactional;

@Transactional
public interface ProjectRoomService {

	public Map<String,Object> getMain(String id, int pj_Num);
	public List<Map<String,Object>> getProgress(int pj_Num);
	public String d_day(int y, int m,int d);
	public int updateLeader(String memberId,int pj_num);
	public int kick(int pjm_num);
}
