package com.example.HAJA.service.member;

import java.util.List;

import com.example.HAJA.model.member.dto.AlarmDTO;

public interface AlarmService {
	public int count(String userid) throws Exception;
	public int countNview(String userid) throws Exception;
	public List<AlarmDTO> list3(String userid) throws Exception;
	public List<AlarmDTO> listAll(String userid, int start, int end) throws Exception;
	public void delete(int ano) throws Exception;
	public String findUserid(int ano) throws Exception;
}
