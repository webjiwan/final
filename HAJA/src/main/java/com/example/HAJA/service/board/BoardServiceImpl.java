package com.example.HAJA.service.board;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.HAJA.model.board.dao.BoardDAO;
import com.example.HAJA.model.board.dao.JoinDAO;
import com.example.HAJA.model.board.dto.BoardDTO;
import com.example.HAJA.model.member.dao.AlarmDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	BoardDAO boardDao;
	
	@Inject
	JoinDAO joinDao;
	
	@Inject
	AlarmDAO alarmDao;
	
	@Override
	public List<BoardDTO> listAll(String category, String keyword, int start, int end) throws Exception {
		return boardDao.listAll(category, keyword, start, end);
	}

	@Override
	public void increaseViewcnt(int bno, HttpSession session) throws Exception {
		long update_time = 0;
		if (session.getAttribute("update_time_"+bno) != null) {
			// 최근에 조회수를 올린 시간
			update_time = (long) session.getAttribute("update_time_"+bno);
		}
		long current_time = System.currentTimeMillis();
		// 일정 시간(5초) 경과한 후 조회수 증가 처리
		if (current_time - update_time > 5*1000) {
			boardDao.increaseViewcnt(bno);
			// 조회수를 올린 시간 저장
			session.setAttribute("update_time_"+bno, current_time);
		}
	}

	@Override
	public BoardDTO read(int bno) throws Exception {
		return boardDao.read(bno);
	}

	@Override
	public int countArticle(String category, String keyword, String isrec) throws Exception {
		return boardDao.countArticle(category, keyword, isrec);
	}
	
	@Transactional
	@Override
	public void delete(int bno) throws Exception {
		//reply 레코드 삭제
		//attach 삭제
		//board 삭제
		String alarmtext = alarmDao.createAlarmText(bno, "vd");
		alarmDao.deleteCreate(bno, alarmtext);
		joinDao.deleteBno(bno);
		boardDao.delete(bno);
		
	}
	
	@Transactional
	@Override
	public void create(BoardDTO dto) throws Exception {
		//board 테이블에 레코드 추가
		boardDao.create(dto);
	}

	@Override
	public String findWriter(int bno) throws Exception {
		return boardDao.findWriter(bno);
	}

	@Transactional
	@Override
	public void update(BoardDTO dto) throws Exception {
		boardDao.update(dto);
	}
}
