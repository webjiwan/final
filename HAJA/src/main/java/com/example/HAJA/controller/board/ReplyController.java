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

import com.example.HAJA.model.board.dto.ReplyDTO;
import com.example.HAJA.service.board.ReplyService;
import com.example.HAJA.service.pager.Pager;

@RestController
@RequestMapping("reply/*")
public class ReplyController {
	private static final Logger logger = LoggerFactory.getLogger(ReplyController.class);
	
	@Inject
	ReplyService replyService;
	
	@RequestMapping("insert.do")
	public ResponseEntity<String> insert(ReplyDTO dto, HttpSession session) throws Exception {
		// 세션 아이디
		String userid = (String) session.getAttribute("userid");

		if (userid == null) return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		
		dto.setReplyer(userid);
		replyService.create(dto);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@RequestMapping("list.do")
	public listReplyDTO list(
			int bno,
			@RequestParam(defaultValue = "1") int curPage) throws Exception {
		int count = replyService.count(bno);
		
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		List<ReplyDTO> list = replyService.listAll(bno, start, end);
		
		listReplyDTO listReplyDto = new listReplyDTO();
		listReplyDto.setList(list);
		listReplyDto.setPager(pager);
		return listReplyDto;
	}
	
	// list.do용 dto
	public class listReplyDTO {
		List<ReplyDTO> list;
		Pager pager;
		
		public List<ReplyDTO> getList() {
			return list;
		}
		public void setList(List<ReplyDTO> list) {
			this.list = list;
		}
		public Pager getPager() {
			return pager;
		}
		public void setPager(Pager pager) {
			this.pager = pager;
		}
	}
	
	@RequestMapping("delete.do")
	public ResponseEntity<String> delete(int rno, HttpSession session) throws Exception {
		String userid = (String) session.getAttribute("userid");
		String findId = replyService.findId(rno);
		findId = (findId == null) ? "" : findId;
		
		if (userid == null || !userid.equals(findId)) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		replyService.delete(rno);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@RequestMapping("edit.do")
	public ResponseEntity<String> edit(ReplyDTO dto, HttpSession session) throws Exception {
		String userid = (String) session.getAttribute("userid");
		String findId = replyService.findId(dto.getRno());
		findId = (findId == null) ? "" : findId;
		
		if (userid == null || !userid.equals(findId)) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		replyService.edit(dto);
		return new ResponseEntity<>(HttpStatus.OK);
	}
}
