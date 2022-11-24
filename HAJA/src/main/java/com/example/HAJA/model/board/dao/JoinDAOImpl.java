package com.example.HAJA.model.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.HAJA.model.board.dto.JoinDTO;

@Repository
public class JoinDAOImpl implements JoinDAO {

	@Inject
	SqlSession sqlSession;
	
	@Override
	public void create(JoinDTO dto) throws Exception {
		sqlSession.insert("join.create", dto);
	}

	/*
	 * jno 나 bno, userid 를 이용해 찾는다
	 * jno 이 0이면 bno, userid 를 이용해 찾는다
	 */
	@Override
	public int findMember(int jno, int bno, String userid) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("jno", jno);
		map.put("userid", userid);
		map.put("bno", bno);
		return sqlSession.selectOne("join.findMember", map);
	}

	/*
	 * bno, userid 중 하나는 있어야 ismatch 옵션을 사용할 수 있다
	 * join table 전체를 구할려면 count(0, null, "all") 해야한다
	 */
	@Override
	public int count(int bno, String userid, String ismatch) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("bno", bno);
		map.put("userid", userid);
		map.put("ismatch", ismatch);
		return sqlSession.selectOne("join.count", map);
	}

	@Override
	public List<JoinDTO> listAll(int bno, int start, int end) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("bno", bno);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("join.listAll", map);
	}

	@Override
	public void changeMatch(int jno, String ismatch) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("jno", jno);
		map.put("ismatch", ismatch);
		sqlSession.update("join.changeMatch", map);
	}

	/*
	 * jno 나 bno, userid 를 이용해 delete를 해야한다.
	 * jno 이 0이면 bno, userid 를 이용해 delete를 한다.
	 */
	@Override
	public void delete(int jno, int bno, String userid) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("jno", jno);
		map.put("bno", bno);
		map.put("userid", userid);
		sqlSession.delete("join.delete", map);
	}

	@Override
	public String findUserid(int jno) throws Exception {
		return sqlSession.selectOne("join.findUserid", jno);
	}

	@Override
	public List<JoinDTO> matchListAll(String userid, int start, int end) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("join.matchListAll", map);
	}

	@Override
	public JoinDTO read(int jno) throws Exception {
		return sqlSession.selectOne("join.read", jno);
	}

	@Override
	public void deleteBno(int bno) throws Exception {
		sqlSession.delete("join.deleteBno", bno);
	}

}
