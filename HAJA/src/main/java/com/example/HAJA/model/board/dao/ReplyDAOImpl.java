package com.example.HAJA.model.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.HAJA.model.board.dto.ReplyDTO;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public void create(ReplyDTO dto) throws Exception {
		sqlSession.insert("reply.insertReply", dto);
	}

	@Override
	public List<ReplyDTO> list(int bno, int start, int end) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("bno", bno);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("reply.listReply", map);
	}

	@Override
	public int count(int bno) throws Exception {
		return sqlSession.selectOne("reply.countReply", bno);
	}

	@Override
	public void delete(int rno) throws Exception {
		sqlSession.delete("reply.deleteReply", rno);
	}

	@Override
	public String findId(int rno) throws Exception {
		return sqlSession.selectOne("reply.findIdReply", rno);
	}

	@Override
	public void edit(ReplyDTO dto) throws Exception {
		sqlSession.update("reply.editReply", dto);
	}

}
