package com.example.HAJA.model.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.HAJA.model.board.dto.BoardDTO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Inject
	SqlSession sqlSession;

	@Override
	public List<BoardDTO> listAll(String category, String keyword, int start, int end) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("category", category);
		map.put("keyword", "%"+keyword+"%");
		map.put("start", start);
		map.put("end", end);
		return sqlSession.selectList("board.listAll", map);
	}

	@Override
	public void increaseViewcnt(int bno) throws Exception {
		sqlSession.update("board.increaseViewcnt",bno);
	}

	@Override
	public BoardDTO read(int bno) throws Exception {
		return sqlSession.selectOne("board.read", bno);
	}

	@Override
	public int countArticle(String category, String keyword, String isrec) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("category", category);
		map.put("keyword", "%"+keyword+"%");
		map.put("isrec", isrec);
		return sqlSession.selectOne("board.countArticle", map);
	}
	
	@Override
	public void delete(int bno) throws Exception {
		sqlSession.delete("board.delete", bno);
		
	}
	
	@Override
	public void create(BoardDTO dto) throws Exception {
		sqlSession.insert("board.insert", dto);
		
	}

	@Override
	public void changeIsrec(int bno, String isrec) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("bno", bno);
		map.put("isrec", isrec);
		sqlSession.update("board.changeIsrec", map);
	}

	@Override
	public String findWriter(int bno) throws Exception {
		return sqlSession.selectOne("board.findWriter", bno);
	}

	@Override
	public void update(BoardDTO dto) throws Exception {
		sqlSession.update("board.update", dto);
	}
}
