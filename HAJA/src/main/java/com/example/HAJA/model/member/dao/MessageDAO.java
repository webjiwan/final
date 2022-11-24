package com.example.HAJA.model.member.dao;

import java.util.List;

import com.example.HAJA.model.member.dto.MessageDTO;

public interface MessageDAO {
	public void create(MessageDTO dto);
	public int countNview(String receive);
	public int count(String receive);
	public List<MessageDTO> list3(String receive);
	public List<MessageDTO> listAll(String receive, int start, int end);
	public void delete(int mno);
	public String findReceive(int mno);
	// dao만
	public void yviewList3(String receive);
	public void yviewListAll(String receive, int start, int end);
}
