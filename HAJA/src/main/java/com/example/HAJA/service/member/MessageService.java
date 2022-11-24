package com.example.HAJA.service.member;

import java.util.List;

import com.example.HAJA.model.member.dto.MessageDTO;

public interface MessageService {
	public void create(MessageDTO dto) throws Exception;
	public int countNview(String receive) throws Exception;
	public int count(String receive) throws Exception;
	public List<MessageDTO> list3(String receive) throws Exception;
	public List<MessageDTO> listAll(String receive, int start, int end) throws Exception;
	public void delete(int mno) throws Exception;
	public String findReceive(int mno) throws Exception;
}
