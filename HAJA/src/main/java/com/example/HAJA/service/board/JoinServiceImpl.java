package com.example.HAJA.service.board;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.HAJA.model.board.dao.BoardDAO;
import com.example.HAJA.model.board.dao.JoinDAO;
import com.example.HAJA.model.board.dto.BoardDTO;
import com.example.HAJA.model.board.dto.JoinDTO;
import com.example.HAJA.model.member.dao.AlarmDAO;
import com.example.HAJA.model.member.dto.AlarmDTO;

@Service
public class JoinServiceImpl implements JoinService {

	@Inject
	JoinDAO joinDao;
	
	@Inject
	BoardDAO boardDao;
	
	@Inject
	AlarmDAO alarmDao;
	
	@Transactional
	@Override
	public void create(JoinDTO dto) throws Exception {
		joinDao.create(dto);
		
		String alarmtext = alarmDao.createAlarmText(dto.getBno(), "wy");
		alarmDao.create(dto.getBno(), dto.getUserid2(), alarmtext);
	}

	@Override
	public int findMember(int jno, int bno, String userid) throws Exception {
		return joinDao.findMember(jno, bno, userid);
	}

	@Override
	public int count(int bno, String userid, String ismatch) throws Exception {
		return joinDao.count(bno, userid, ismatch);
	}

	@Override
	public List<JoinDTO> listAll(int bno, int start, int end) throws Exception {
		return joinDao.listAll(bno, start, end);
	}

	@Transactional
	@Override
	public void changeMatch(int jno, String ismatch) throws Exception {
		joinDao.changeMatch(jno, ismatch);
		
		JoinDTO joinDto = joinDao.read(jno);
		if (ismatch.equals("y")) {
			boardDao.changeIsrec(joinDao.read(jno).getBno(), "n");
			
			String alarmtext = alarmDao.createAlarmText(joinDto.getBno(), "vy");
			alarmDao.create(joinDto.getBno(), joinDto.getUserid(), alarmtext);
		}
		
		if (ismatch.equals("n")) {
			boardDao.changeIsrec(joinDao.read(jno).getBno(), "y");
			
			String alarmtext = alarmDao.createAlarmText(joinDto.getBno(), "vn");
			alarmDao.create(joinDto.getBno(), joinDto.getUserid(), alarmtext);
		}
	}

	/*
	 * jno 나 bno, userid 를 이용해 delete를 해야한다.
	 * jno 가 0이면 bno, userid 를 이용해 delete를 한다.
	 */
	@Transactional
	@Override
	public void delete(int jno, int bno, String userid) throws Exception {
		if (jno != 0) {
			JoinDTO joinDto = joinDao.read(jno);
			if ( joinDto.getIsmatch().equals("y") ) {
				boardDao.changeIsrec(joinDto.getBno(), "y");
				
				if ( !userid.equals(joinDto.getUserid2()) ) { // 매칭이 되있고 지우는게 참가자라면
					String alarmtext = alarmDao.createAlarmText(joinDto.getBno(), "wmn");
					alarmDao.create(joinDto.getBno(), joinDto.getUserid2(), alarmtext);
				} else { // 매칭이 되있고 지우는게 모집자라면
					String alarmtext = alarmDao.createAlarmText(joinDto.getBno(), "vn");
					alarmDao.create(joinDto.getBno(), joinDto.getUserid(), alarmtext);
				}
			} else { // 매칭이 안되어있으면 
				if ( !userid.equals(joinDto.getUserid2()) ) { // 지우는게 참가자라면
					String alarmtext = alarmDao.createAlarmText(joinDto.getBno(), "wn");
					alarmDao.create(joinDto.getBno(), joinDto.getUserid2(), alarmtext);
				}
			}
		}
		
		if (bno != 0) {
			try {
				BoardDTO boardDto = boardDao.read(bno);
				if ( boardDto.getIsrec().equals("n") ) {
					boardDao.changeIsrec(bno, "y");
					
					if ( !userid.equals(boardDto.getWriter()) ) { // 매칭이 되있고 지우는게 참가자라면
						String alarmtext = alarmDao.createAlarmText(bno, "wmn");
						alarmDao.create(bno, boardDto.getWriter(), alarmtext);
					}
				} else { // 매칭이 안되있으면
					if ( !userid.equals(boardDto.getWriter()) ) { // 지우는게 참가자라면
						String alarmtext = alarmDao.createAlarmText(bno, "wn");
						alarmDao.create(bno, boardDto.getWriter(), alarmtext);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		joinDao.delete(jno, bno, userid);
	}

	@Override
	public String findUserid(int jno) throws Exception {
		return joinDao.findUserid(jno);
	}

	@Override
	public List<JoinDTO> matchListAll(String userid, int start, int end) throws Exception {
		return joinDao.matchListAll(userid, start, end);
	}

	@Override
	public JoinDTO read(int jno) throws Exception {
		return joinDao.read(jno);
	}

}
