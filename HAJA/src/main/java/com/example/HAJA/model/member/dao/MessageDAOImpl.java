package com.example.HAJA.model.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.HAJA.model.member.dto.MessageDTO;

@Repository
public class MessageDAOImpl implements MessageDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public void create(MessageDTO dto) {
		sqlSession.insert("message.create", dto);
	}

	@Override
	public int countNview(String receive) {
		return sqlSession.selectOne("message.countNview", receive);
	}

	@Override
	public List<MessageDTO> list3(String receive) {
		return sqlSession.selectList("message.list3", receive);
	}

	@Override
	public void yviewList3(String receive) {
		sqlSession.update("message.list3Yview", receive);
	}

	@Override
	public int count(String receive) {
		return sqlSession.selectOne("message.count", receive);
	}

	@Override
	public List<MessageDTO> listAll(String receive, int start, int end) {
		Map<String, Object> map = new HashMap<>();
		map.put("receive", receive);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("message.listAll", map);
	}

	@Override
	public void yviewListAll(String receive, int start, int end) {
		Map<String, Object> map = new HashMap<>();
		map.put("receive", receive);
		map.put("start", start);
		map.put("end", end);
		sqlSession.update("message.listAllYview", map);
	}

	@Override
	public void delete(int mno) {
		sqlSession.delete("message.delete", mno);
	}

	@Override
	public String findReceive(int mno) {
		return sqlSession.selectOne("message.findReceive", mno);
	}

}
