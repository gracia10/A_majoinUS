package controller.LSH.projectroom;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.KMJ;
import exception.BadRequestException;

@Service
public class ProjectRoomServiceImpl implements ProjectRoomService{

	@Autowired
	private ProjectRoomDAO projectRoomDAO;
	
	@Autowired
	private KMJ mj_dao;
	
	public Map<String,Object> getMain(String id, int pj_Num) {
		Map<String,Object> map = new HashMap<String,Object>();
		
		try {
			map.put("pjm_num", mj_dao.getpjm_num(pj_Num, id));
			map.put("list", getProgress(pj_Num));
		} catch (NullPointerException e) {
			throw new BadRequestException("Can't find ProjectRoom (NULL)");
		}

		return map;
	}
	
	public List<Map<String,Object>> getProgress(int pj_Num){
		
		int total = 0,complete = 0;
		Map<String,Object> temp_m = new HashMap<String,Object>();
		String end_d="",d_day="";
		
		List<Map<String,Object>> list = projectRoomDAO.getProgress("LSH_AUS.getProgress",pj_Num);
		
		for(int i=0,a=0,b=0,c=0; i< list.size();i+=1) {
			a = Integer.parseInt(list.get(i).get("ONGOING").toString());
			b = Integer.parseInt(list.get(i).get("COMPLETE").toString());
			c = Integer.parseInt(list.get(i).get("DELAY").toString());
			
			list.get(i).put("total", a+b+c);
			total += a+b+c;
			complete += b;
			
			if(list.get(i).get("LEADER").equals(list.get(i).get("MEM_ID"))) {
				temp_m = list.get(i);
				list.remove(i);
				list.add(0,temp_m);
			}
		}
		
        list.get(0).put("percent", (total == 0)? 0: (complete*100)/ total);
		
		String[] temp = list.get(0).get("END_D").toString().split("-");
		
		if(Integer.parseInt(temp[0]) >= 2099){
			end_d = "무기한";
			d_day = "9999";
		}else {
			end_d = temp[0]+"-"+temp[1]+"-"+temp[2].split(" ")[0];
			d_day = d_day(Integer.parseInt(temp[0]),Integer.parseInt(temp[1])-1,Integer.parseInt(temp[2].split(" ")[0]));
		}

		list.get(0).replace("END_D",end_d);
		list.get(0).put("d_day", d_day);
		return list;
	}
	
	
	public String d_day(int y, int m,int d) {
		Calendar now = Calendar.getInstance();
		Calendar dday = Calendar.getInstance();
		dday.set(y,m,d);
		long substract = (long)dday.getTimeInMillis()/(24*60*60*1000)-(long)now.getTimeInMillis()/(24*60*60*1000);		
		return String.valueOf(substract);
	}

	public int updateLeader(String memberId,int pj_num) {
		
		Map<String,Object> m = new HashMap<String,Object>();
		m.put("id", memberId);
		m.put("pj_num", pj_num);
		
		int x = projectRoomDAO.updateLeader("LSH_AUS.update_leader", m);
		return x;
	}
	
	public int kick(int pjm_num) {
	    int x = projectRoomDAO.kick("LSH_AUS.kick", pjm_num);
	    return x;
	}
}
