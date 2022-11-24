package com.example.HAJA.service.board;

import java.util.List;

import com.example.HAJA.model.board.dto.JoinDTO;

public interface JoinService {
	public void create(JoinDTO dto) throws Exception;
	public int findMember(int jno, int bno, String userid) throws Exception;
	public int count(int bno, String userid, String ismatch) throws Exception;
	public List<JoinDTO> listAll(int bno, int start, int end) throws Exception;
	public void changeMatch(int jno, String ismatch) throws Exception;
	public void delete(int jno, int bno, String userid) throws Exception;
	public String findUserid(int jno) throws Exception;
	public List<JoinDTO> matchListAll(String userid, int start, int end) throws Exception;
	public JoinDTO read(int jno) throws Exception;
}
