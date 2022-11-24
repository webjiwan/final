package com.example.HAJA.service.member;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.HAJA.model.member.dao.AlarmDAO;
import com.example.HAJA.model.member.dto.AlarmDTO;

@Service
public class AlarmServiceImpl implements AlarmService {
	
	@Inject
	AlarmDAO alarmDao;
	
	@Override
	public int countNview(String userid) throws Exception {
		return alarmDao.countNview(userid);
	}

	@Transactional
	@Override
	public List<AlarmDTO> list3(String userid) throws Exception {
		List<AlarmDTO> list = alarmDao.list3(userid);
		alarmDao.yviewList3(userid);
		return list;
	}

	@Override
	public List<AlarmDTO> listAll(String userid, int start, int end) throws Exception {
		alarmDao.yviewListAll(userid, start, end);
		return alarmDao.listAll(userid, start, end);
	}

	@Override
	public int count(String userid) throws Exception {
		return alarmDao.count(userid);
	}

	@Override
	public void delete(int ano) throws Exception {
		alarmDao.delete(ano);;
	}

	@Override
	public String findUserid(int ano) throws Exception {
		return alarmDao.findUserid(ano);
	}

}
