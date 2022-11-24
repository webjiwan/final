package com.example.HAJA.model.board.dao;

import java.util.List;

import com.example.HAJA.model.board.dto.BoardDTO;

public interface BoardDAO {
	public List<BoardDTO> listAll(String category, String keyword, int start, int end) throws Exception; // 게시물목록 리턴
	public void increaseViewcnt(int bno) throws Exception; // 조회수 증가 처리
	public BoardDTO read(int bno) throws Exception; // 레코드 조회
	public int countArticle(String category, String keyword, String isrec) throws Exception; // 레코드 갯수 계산
	public void delete(int bno) throws Exception; //글삭제
	public void create(BoardDTO dto) throws Exception; //글쓰기
	public String findWriter(int bno) throws Exception; // 글작성자 찾기
	public void update(BoardDTO dto) throws Exception; //글수정 
	
	// dao만
	public void changeIsrec(int bno, String isrec) throws Exception; // 매칭변화
}
