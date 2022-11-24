package com.example.HAJA.model.member.dao;

import java.util.List;

import com.example.HAJA.model.member.dto.AlarmDTO;

public interface AlarmDAO {
	public int count(String userid) throws Exception;
	public int countNview(String userid) throws Exception;
	public List<AlarmDTO> list3(String userid) throws Exception;
	public List<AlarmDTO> listAll(String userid, int start, int end) throws Exception;
	public void delete(int ano) throws Exception;
	public String findUserid(int ano) throws Exception;
	// dao만
	public void yviewList3(String userid) throws Exception;
	public void yviewListAll(String userid, int start, int end) throws Exception;
	public void create(int bno, String userid, String alarmtext) throws Exception;
	public void deleteCreate(int bno, String alarmtext) throws Exception;
	public String createAlarmText(int bno, String option) throws Exception;
}
