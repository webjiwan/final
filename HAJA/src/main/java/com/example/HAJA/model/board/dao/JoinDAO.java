package com.example.HAJA.model.board.dao;

import java.util.List;

import com.example.HAJA.model.board.dto.JoinDTO;

public interface JoinDAO {
	public void create(JoinDTO dto) throws Exception; // 참가레코드 생성
	public int findMember(int jno, int bno, String userid) throws Exception; // jno 나 bno, userid 를 이용해 참가 여부확인
	public int count(int bno, String userid, String ismatch) throws Exception; // bno 나 userid 를 이용해 총 레코드 수 확인 (ismatch 매칭여부 옵션) 
	public List<JoinDTO> listAll(int bno, int start, int end) throws Exception; // bno 를 이용해 목록리턴
	public void changeMatch(int jno, String ismatch) throws Exception; // jno 를 이용해 ismatch 업데이트
	public void delete(int jno, int bno, String userid) throws Exception; // jno 나 bno, userid 를 이용해 참가레코드 삭제
	public String findUserid(int jno) throws Exception; // 글쓴이 확인
	public List<JoinDTO> matchListAll(String userid, int start, int end) throws Exception; // userid 를 이용해 목록리턴
	public JoinDTO read(int jno) throws Exception; // 레코드 읽기
	
	// dao만
	public void deleteBno(int bno) throws Exception; // 레코드 삭제
}
