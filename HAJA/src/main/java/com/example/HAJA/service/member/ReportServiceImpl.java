package com.example.HAJA.service.member;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.example.HAJA.model.member.dao.ReportDAO;
import com.example.HAJA.model.member.dto.ReportDTO;

@Service
public class ReportServiceImpl implements ReportService {

	@Inject
	ReportDAO reportDao;
	
	@Override
	public void create(ReportDTO dto) throws Exception {
		reportDao.create(dto);
	}

	@Override
	public int duplicate(String send, String receive) throws Exception {
		return reportDao.duplicate(send, receive);
	}
	
	@Override
	public int count(String receive) throws Exception {
		return reportDao.count(receive);
	}

	@Override
	public int categoryCount(String receive, String category) throws Exception {
		return reportDao.categoryCount(receive, category);
	}
	
	@Override
	public List<ReportDTO> listAll(String receive, int start, int end) throws Exception {
		return reportDao.listAll(receive, start, end);
	}

}
