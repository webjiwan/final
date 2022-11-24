package com.example.HAJA.service.member;

import java.util.List;

import com.example.HAJA.model.member.dto.ReportDTO;

public interface ReportService {
	public void create(ReportDTO dto) throws Exception;
	public int duplicate(String send, String receive) throws Exception;
	public int count(String receive) throws Exception;
	public int categoryCount(String receive, String category) throws Exception;
	public List<ReportDTO> listAll(String receive, int start, int end) throws Exception;
}
