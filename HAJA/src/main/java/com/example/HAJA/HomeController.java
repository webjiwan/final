package com.example.HAJA;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.example.HAJA.service.board.BoardService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Inject
	BoardService boardService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 * @throws Exception 
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(HttpSession session) throws Exception {
		
		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();
		map.put("isrec_count_all", boardService.countArticle("all", "", "y"));
		map.put("isrec_count_soccer", boardService.countArticle("soccer", "", "y"));
		map.put("isrec_count_basketball", boardService.countArticle("basketball", "", "y"));
		map.put("isrec_count_baseball", boardService.countArticle("baseball", "", "y"));
		map.put("isrec_count_etc", boardService.countArticle("etc", "", "y"));
		mav.addObject("map", map);
		mav.setViewName("haja/index");
		return mav;
	}
	
	// test
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test() {
		return "haja/member/report_list";
	}
	
}
