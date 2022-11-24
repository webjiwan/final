package com.example.HAJA.controller.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.HAJA.model.board.dto.BoardDTO;
import com.example.HAJA.service.board.BoardService;
import com.example.HAJA.service.board.JoinService;
import com.example.HAJA.service.pager.Pager;


@Controller
@RequestMapping("board/*")
public class BoardController {
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Inject
	BoardService boardService;
	
	@Inject
	JoinService joinService;
	
	@RequestMapping("list.do")
	public ModelAndView list(
			@RequestParam(defaultValue = "soccer") String category,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam(defaultValue = "1") int curPage) throws Exception {
		// 모집여부 레코드 포함 변수
		String isrec = "all";
		// 레코드 갯수 계산
		int count = boardService.countArticle(category, keyword, isrec);
		// 페이지 관련 설정
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		List<BoardDTO> list = boardService.listAll(category, keyword, start, end);

		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("pager", pager);
		map.put("category", category);
		mav.addObject("map", map);
		mav.addObject("placeholder", "제목이나 팀이름을 입력하세요");
		mav.setViewName("haja/board/list");
		return mav;
	}
	
	@RequestMapping("view.do")
	public ModelAndView view(
			@RequestParam(defaultValue = "0") int jno,
			@RequestParam(defaultValue = "0") int bno, HttpSession session) throws Exception {
		boardService.increaseViewcnt(bno, session); // 조회수 증가
		
		String ismatch = "n";
		String userid = (String) session.getAttribute("userid");
		
		if (userid != null) {
			if (joinService.findMember(jno, bno, userid) > 0) ismatch = "y";
		}
		
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();
		map.put("dto", boardService.read(bno));
		map.put("ismatch", ismatch);
		mav.addObject("map", map);
		mav.setViewName("haja/board/view");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("delete.do")
	public ResponseEntity<String> delete(int bno, HttpSession session) throws Exception {
		String userid = (String) session.getAttribute("userid");
		String findId = boardService.findWriter(bno);
		findId = (findId == null) ? "" : findId;
		
		if (userid == null || !userid.equals(findId) ) {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		boardService.delete(bno);
		return new ResponseEntity<>(HttpStatus.OK);
	}
	
	@RequestMapping("write.do")
	public String write() {
		//글쓰기 폼 페이지로 이동
		return "haja/board/write";
	}
	
	//글쓰기
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute BoardDTO dto, HttpSession session) throws Exception {
		String userid = (String) session.getAttribute("userid");
		
		if (userid == null) return "redirect:/member/login.do";
		
		dto.setWriter(userid);
		boardService.create(dto);
		return "redirect:/board/list.do?category="+dto.getCategory();
	}
	
	//게시물 내용 수정
	@RequestMapping("updateBoard.do")
	public ModelAndView updateBoard(@ModelAttribute BoardDTO dto, HttpSession session, HttpServletRequest request) throws Exception {
		String userid = (String) session.getAttribute("userid");
		String findId = boardService.findWriter(dto.getBno());
		
		ModelAndView mav = new ModelAndView();
		if (userid == null || findId == null || !userid.equals(findId)) {
			mav.addObject("message", "아이디가 없거나 작성자와 달라 수정할 수 없습니다");
			mav.setViewName("redirect:"+request.getHeader("Referer"));
			return mav;
		}
		
		boardService.update(dto);
		mav.setViewName("redirect:/board/list.do?category="+dto.getCategory());
		return mav;
	}
	
	//게시물 내용 수정페이지
	@RequestMapping("update.do")
	public ModelAndView update(int bno, HttpSession session, HttpServletRequest request) throws Exception {
		String userid = (String) session.getAttribute("userid");
		String findId = boardService.findWriter(bno);
		
		ModelAndView mav = new ModelAndView();
		if (userid == null || findId == null || !userid.equals(findId)) {
			mav.addObject("message", "아이디가 없거나 작성자와 달라 수정할 수 없습니다");
			mav.setViewName("redirect:"+request.getHeader("Referer"));
			return mav;
		}
		
		//글쓰기 폼 페이지로 이동
		Map<String, Object> map = new HashMap<>();
		map.put("dto", boardService.read(bno));
		mav.addObject("map", map);
		mav.setViewName("haja/board/update");
		return mav;
	}
}
