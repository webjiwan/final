package com.example.HAJA.model.board.dao;

import java.util.List;

import com.example.HAJA.model.board.dto.ReplyDTO;

public interface ReplyDAO {
	public void create(ReplyDTO dto) throws Exception; // 댓글 생성
	public List<ReplyDTO> list(int bno, int start, int end) throws Exception; // 댓글 목록
	public int count(int bno) throws Exception; // 게시물의 댓글 수
	public void delete(int rno) throws Exception; // 댓글 삭제
	public String findId(int rno) throws Exception; // 댓글의 작성자 리턴
	public void edit(ReplyDTO dto) throws Exception; // 댓글 업데이트
}
