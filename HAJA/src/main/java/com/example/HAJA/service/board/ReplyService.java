package com.example.HAJA.service.board;

import java.util.List;

import com.example.HAJA.model.board.dto.ReplyDTO;

public interface ReplyService {
	public void create(ReplyDTO dto) throws Exception;
	public List<ReplyDTO> listAll(int bno, int start, int end) throws Exception;
	public int count(int bno) throws Exception;
	public void delete(int rno) throws Exception;
	public String findId(int rno) throws Exception;
	public void edit(ReplyDTO dto) throws Exception;
}
