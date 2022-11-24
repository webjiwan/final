package com.example.HAJA.model.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.HAJA.model.member.dto.ReportDTO;

@Repository
public class ReportDAOImpl implements ReportDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public void create(ReportDTO dto) throws Exception {
		sqlSession.insert("report.create", dto);
	}

	@Override
	public int duplicate(String send, String receive) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("send", send);
		map.put("receive", receive);
		return sqlSession.selectOne("report.duplicate", map);
	}

	@Override
	public int count(String receive) throws Exception {
		return sqlSession.selectOne("report.count", receive);
	}
	
	@Override
	public int categoryCount(String receive, String category) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("receive", receive);
		map.put("category", "%"+category+"%");
		return sqlSession.selectOne("report.categoryCount", map);
	}
	
	@Override
	public List<ReportDTO> listAll(String receive, int start, int end) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("receive", receive);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("report.listAll", map);
	}



}
