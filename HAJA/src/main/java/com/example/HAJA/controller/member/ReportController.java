package com.example.HAJA.controller.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.HAJA.model.member.dto.ReportDTO;
import com.example.HAJA.service.member.ReportService;
import com.example.HAJA.service.pager.Pager;

@RestController
@RequestMapping("report/*")
public class ReportController {
	private static final Logger logger = LoggerFactory.getLogger(ReportController.class);
	
	@Inject
	ReportService reportService;
	
	@RequestMapping(value = "create.do", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> create(HttpSession session,
			String text, String receive, String category) throws Exception {
		String userid = (String) session.getAttribute("userid");
		
		if (text.isEmpty() || category.isEmpty()) return createErrorMessage("입력안하신 값이 있습니다");
		if (userid == null) return createErrorMessage("로그인을 안했습니다");
		if (receive == null || userid.equals(receive)) return createErrorMessage("상대가 없거나 자기자신을 고를 수 없습니다");
		if (reportService.duplicate(userid, receive) > 0) return createErrorMessage("이미 신고를 보낸 상대입니다");
		
		ReportDTO reportDto = new ReportDTO();
		reportDto.setSend(userid);
		reportDto.setReceive(receive);
		reportDto.setCategory(category);
		reportDto.setText(text);
		
		reportService.create(reportDto);
		return createSuccessMessage("신고했습니다");
	}
	
	@RequestMapping("list.do")
	public ModelAndView list(
			@RequestParam(defaultValue = "1") int curPage,
			String receive) throws Exception {
		int count = reportService.count(receive);
		
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		List<ReportDTO> list = reportService.listAll(receive, start, end);
		
		Map<String, Object> map = new HashMap<>();
		map.put("c1", reportService.categoryCount(receive, "욕설"));
		map.put("c2", reportService.categoryCount(receive, "비매너 행위"));
		map.put("c3", reportService.categoryCount(receive, "무단지각"));
		map.put("c4", reportService.categoryCount(receive, "무단불참, 무단탈주"));
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("haja/member/report_list");
		mav.addObject("list", list);
		mav.addObject("pager", pager);
		mav.addObject("map", map);
		mav.addObject("count", count);
		return mav;
	}
	
	public ResponseEntity<String> createErrorMessage(String msg) {
		return new ResponseEntity<>(msg, HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	public ResponseEntity<String> createSuccessMessage(String msg) {
		return new ResponseEntity<>(msg, HttpStatus.OK);
	}
}
