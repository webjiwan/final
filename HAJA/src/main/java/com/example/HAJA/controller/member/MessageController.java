package com.example.HAJA.controller.member;

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

import com.example.HAJA.controller.board.BoardController;
import com.example.HAJA.model.board.dto.JoinDTO;
import com.example.HAJA.model.member.dto.MessageDTO;
import com.example.HAJA.service.board.BoardService;
import com.example.HAJA.service.board.JoinService;
import com.example.HAJA.service.board.ReplyService;
import com.example.HAJA.service.member.MemberService;
import com.example.HAJA.service.member.MessageService;
import com.example.HAJA.service.pager.Pager;

@RestController
@RequestMapping("message/*")
public class MessageController {
	private static final Logger logger = LoggerFactory.getLogger(MessageController.class);

	@Inject
	MemberService memberService;
	
	@Inject
	BoardService boardService;
	
	@Inject
	ReplyService replyService;
	
	@Inject
	JoinService joinService;
	
	@Inject
	MessageService messageService;
	
	@RequestMapping("create.do")
	public ResponseEntity<String> create(
			HttpSession session, String text, String receive) throws Exception {
		String userid = (String) session.getAttribute("userid");
				
		if (userid == null || receive == null || userid.equals(receive) || memberService.viewMember(receive) == null) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		MessageDTO dto = new MessageDTO();
		dto.setSend(userid);
		dto.setReceive(receive);
		dto.setText(text);
		dto.setIsview("n");
		messageService.create(dto);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@RequestMapping("recentMessageUpdate.do")
	public MessageUpdateDTO recentMessageUpdate(HttpSession session) throws Exception {
		String userid = (String) session.getAttribute("userid");
		
		List<MessageDTO> list = messageService.list3(userid);
		
		MessageUpdateDTO messageUpdateDto = new MessageUpdateDTO();
		messageUpdateDto.setMessageCnt(messageService.countNview(userid));
		messageUpdateDto.setList(list);
		
		session.setAttribute("messageNviewCnt", messageUpdateDto.getMessageCnt());
		return messageUpdateDto;
	}
	
	public class MessageUpdateDTO {
		int messageCnt;
		List<MessageDTO> list;
		public int getMessageCnt() {
			return messageCnt;
		}
		public void setMessageCnt(int messageCnt) {
			this.messageCnt = messageCnt;
		}
		public List<MessageDTO> getList() {
			return list;
		}
		public void setList(List<MessageDTO> list) {
			this.list = list;
		}
	}
	
	@RequestMapping("messageList.do")
	public ModelAndView messageList(
			@RequestParam(defaultValue = "1") int curPage,
			HttpSession session) throws Exception {
		String userid = (String) session.getAttribute("userid");
		
		int count = messageService.count(userid);
		
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		List<MessageDTO> list = messageService.listAll(userid, start, end);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("haja/member/message_list");
		mav.addObject("list", list);
		mav.addObject("pager", pager);
				
		session.setAttribute("messageNviewCnt", messageService.countNview(userid));
		return mav;
	}
	
	@RequestMapping("messageForm")
	public ModelAndView messageForm() throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("haja/member/message_form");
		return mav;
	}
	
	@RequestMapping("delete.do")
	public ResponseEntity<String> delete(int mno, HttpSession session) throws Exception {
		String userid = (String) session.getAttribute("userid");
		String findId = messageService.findReceive(mno);
		findId = (findId == null) ? "" : findId;
		
		if (userid == null || !userid.equals(findId)) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		messageService.delete(mno);
		return new ResponseEntity<>(HttpStatus.OK);
	}
}
