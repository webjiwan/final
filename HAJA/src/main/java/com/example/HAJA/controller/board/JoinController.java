package com.example.HAJA.controller.board;

import java.util.List;

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

import com.example.HAJA.model.board.dto.JoinDTO;
import com.example.HAJA.service.board.JoinService;
import com.example.HAJA.service.pager.JoinPager;
import com.example.HAJA.service.pager.Pager;

@RestController
@RequestMapping("join/*")
public class JoinController {
	private static final Logger logger = LoggerFactory.getLogger(JoinController.class);
	
	@Inject
	JoinService joinService;
	
	
	@RequestMapping("create.do")
	public ResponseEntity<String> create(
			@RequestParam(defaultValue = "0") int jno,
			@RequestParam(defaultValue = "0") int bno, String writer, HttpSession session) throws Exception {
		String userid = (String) session.getAttribute("userid");
		
		if (userid == null || joinService.findMember(jno, bno, userid) > 0) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		JoinDTO dto = new JoinDTO();
		dto.setBno(bno);
		dto.setUserid(userid);
		dto.setUserid2(writer);
		dto.setIsmatch("n");
		
		joinService.create(dto);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@RequestMapping("matchList")
	public ModelAndView matchList() throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("haja/board/match_list");
		return mav;
	}
	
	@RequestMapping("matchList.do")
	public listJoinDTO matchList(
			@RequestParam(defaultValue = "1") int curPage,
			HttpSession session) throws Exception {
		String userid = (String) session.getAttribute("userid");
		
		int count = joinService.count(0, userid, "all");
		
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		List<JoinDTO> list = joinService.matchListAll(userid, start, end);
		
		listJoinDTO listJoinDto = new listJoinDTO();
		listJoinDto.setList(list);
		listJoinDto.setPager(pager);
		return listJoinDto;
	}
	
	@RequestMapping("list.do")
	public listJoinDTO list(
			int bno,
			@RequestParam(defaultValue = "1") int curPage) throws Exception {
		int count = joinService.count(bno, null, "all");
		int isMatch = joinService.count(bno, null, "y");
		
		JoinPager pager = new JoinPager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		List<JoinDTO> list = joinService.listAll(bno, start, end);
		
		listJoinDTO listJoinDto = new listJoinDTO();
		listJoinDto.setList(list);
		listJoinDto.setJoinPager(pager);
		listJoinDto.setIsMatch(isMatch);
		return listJoinDto;
	}
	
	// matchList.do, list.do용 dto
	public class listJoinDTO {
		List<JoinDTO> list;
		Pager pager;
		JoinPager joinPager;
		int isMatch;
		public List<JoinDTO> getList() {
			return list;
		}
		public void setList(List<JoinDTO> list) {
			this.list = list;
		}
		public Pager getPager() {
			return pager;
		}
		public void setPager(Pager pager) {
			this.pager = pager;
		}
		public JoinPager getJoinPager() {
			return joinPager;
		}
		public void setJoinPager(JoinPager joinPager) {
			this.joinPager = joinPager;
		}
		public int getIsMatch() {
			return isMatch;
		}
		public void setIsMatch(int isMatch) {
			this.isMatch = isMatch;
		}
	}
	
	@RequestMapping("changeMatch.do")
	public ResponseEntity<String> changeMatch(int jno, String ismatch, HttpSession session) throws Exception {
		String userid = (String) session.getAttribute("userid");
		String findId = joinService.findUserid(jno);
		findId = (findId == null) ? "" : findId;
		
		if (userid == null || !userid.equals(findId)) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		joinService.changeMatch(jno, ismatch);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@RequestMapping("delete.do")
	public ResponseEntity<String> delete(
			@RequestParam(defaultValue = "0") int jno,
			@RequestParam(defaultValue = "0") int bno, HttpSession session) throws Exception {
		String userid = (String) session.getAttribute("userid");
		
		if (userid == null || joinService.findMember(jno, bno, userid) == 0) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		joinService.delete(jno, bno, userid);
		return new ResponseEntity<>(HttpStatus.OK);
	}
}
