package com.example.HAJA.model.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.HAJA.model.member.dto.AlarmDTO;

@Repository
public class AlarmDAOImpl implements AlarmDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public int countNview(String userid) throws Exception {
		return sqlSession.selectOne("alarm.countNview", userid);
	}
	
	@Override
	public List<AlarmDTO> list3(String userid) throws Exception {
		return sqlSession.selectList("alarm.list3", userid);
	}
	
	@Override
	public void create(int bno, String userid, String alarmtext) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("bno", bno);
		map.put("userid", userid);
		map.put("alarmtext", alarmtext);
		sqlSession.insert("alarm.create", map);
	}

	@Override
	public String createAlarmText(int bno, String option) throws Exception {
		String alarmText = "";
		
		switch (option) {
		case "wy":
			alarmText = "만드신 <a href='/board/view.do?bno="+bno+"' class='text-primary'>모집방</a>에서 한 팀이 참가하셨습니다.";
			break;
		case "wn":
			alarmText = "만드신 <a href='/board/view.do?bno="+bno+"' class='text-primary'>모집방</a>에서 한 팀이 참가를 취소하셨습니다.";
			break;
		case "wmn":
			alarmText = "만드신 <a href='/board/view.do?bno="+bno+"' class='text-primary'>모집방</a>에서 한 팀이 참가를 취소해 매칭이 취소되였습니다.";
			break;
		case "vy":
			alarmText = "참여하신 <a href='/board/view.do?bno="+bno+"' class='text-primary'>모집방</a>에서 매칭되였습니다.";
			break;
		case "vn":
			alarmText = "참여하신 <a href='/board/view.do?bno="+bno+"' class='text-primary'>모집방</a>에서 매칭이 취소되였습니다.";
			break;
		case "vd":
			alarmText = "참여하신 모집방이 삭제되었습니다.  <a href='/join/matchList' class='text-primary'>매칭현황</a>";
			break;
		}
		
		return alarmText;
	}

	@Override
	public void yviewList3(String userid) throws Exception {
		sqlSession.update("alarm.list3Yview", userid);
	}

	@Override
	public List<AlarmDTO> listAll(String userid, int start, int end) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("alarm.listAll", map);
	}

	@Override
	public void yviewListAll(String userid, int start, int end) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("start", start);
		map.put("end", end);
		sqlSession.update("alarm.listAllYview", map);
	}

	@Override
	public int count(String userid) throws Exception {
		return sqlSession.selectOne("alarm.count", userid);
	}

	@Override
	public void delete(int ano) throws Exception {
		sqlSession.delete("alarm.delete", ano);
	}

	@Override
	public String findUserid(int ano) throws Exception {
		return sqlSession.selectOne("alarm.findUserid", ano);
	}

	@Override
	public void deleteCreate(int bno, String alarmtext) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("bno", bno);
		map.put("alarmtext", alarmtext);
		sqlSession.insert("alarm.deleteCreate", map);
	}
}
