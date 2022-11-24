package com.example.HAJA.controller.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.HAJA.model.member.dto.MemberDTO;
import com.example.HAJA.service.member.MemberService;
import com.example.HAJA.service.pager.Pager;

@Controller
@RequestMapping("member/*")
public class MemberController {
	//로깅
	private static final Logger logger=
			LoggerFactory.getLogger(MemberController.class);
	
	@Inject
	MemberService memberService;
	
	@RequestMapping("join.do")
	public String join() {
		return "haja/member/join";
	}
	
	@RequestMapping("find.do")
	public String find() {
		return "haja/member/find";
	}
	
	@RequestMapping("login.do")
	public String login() {
		return "haja/member/login";

	}
	
	@RequestMapping("home.do")
	public String home() {
	   return "redirect:/";
	}
	
	@RequestMapping("admin.do")
	public ModelAndView list(
			// 페이징 관련 변경 부분
		@RequestParam(defaultValue = "1") int curPage,
	    @RequestParam(defaultValue = "") String keyword) throws Exception {
		int count = memberService.countMember();
		Pager pager = new Pager(count, curPage);
		int start = pager.getPageBegin();
		int end = pager.getPageEnd();
		
		List<MemberDTO> list = memberService.list(start, end, keyword);

		ModelAndView mav = new ModelAndView();
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("count", count);
		map.put("pager", pager);
		mav.addObject("map", map);
		mav.addObject("placeholder", "찾고자 하는 아이디를 입력하세요");
		mav.setViewName("haja/member/admin");
		return mav;
		
	}
	
	//@RequestMapping("admin.do")
	//public String admin(Model model) {
	//	List<MemberDTO> list=memberService.list();
	//	model.addAttribute("list", list);
	//	return "haja/member/admin";
	//}
	
	@RequestMapping("login_check.do")
	public ModelAndView check(MemberDTO dto, HttpSession session) throws Exception {
		//로그인 성공 true, 실패 false
		String name=memberService.login_check(dto, session);
		ModelAndView mav=new ModelAndView();
		if(name != null) {//로그인 성공
			mav.setViewName("redirect:/"); 
		}else {//로그인 실패
			mav.setViewName("haja/member/login");
			//뷰에 전달할 값
			mav.addObject("message", "error");
		}
		return mav;
	}
	
	@RequestMapping("logout.do")
	public ModelAndView logout(HttpSession session, ModelAndView mav) {
		//세션 초기화
		memberService.logout(session);
		// login.jsp로 이동
		mav.setViewName("redirect:/");
		mav.addObject("message", "logout");
		return mav;
	}
	
	//회원 데이터 입력
	@RequestMapping("insert.do")
	public String insert(@ModelAttribute MemberDTO dto) {
		memberService.insertMember(dto);
		
		return "haja/member/login";
	}
	
	//회원정보 수정(관련)
    @RequestMapping("view.do")
    public String view(Model model, HttpSession session) {
       String userid = (String) session.getAttribute("userid");
       //모델에 자료 저장 
       model.addAttribute("dto",memberService.viewMember(userid));
      
       return "haja/member/view";
    }
	
	//회원정보 수정
	@RequestMapping("update.do")
	public String update(MemberDTO dto, Model model) {
		//비밀번호 check 
		boolean result = memberService.checkPw(dto.getUserid(), dto.getPasswd());
		if(result) { //비밀번호가 맞으면
			//회원정보 수정
			memberService.updateMember(dto);
			//수정한 후 홈으로 이동
			return "redirect:/";
		} else {
			//비밀번호가 틀리면
			model.addAttribute("dto", dto);
			model.addAttribute("join_date", memberService.viewMember(dto.getUserid()).getJoin_date());
			model.addAttribute("message", "비밀번호를 확인하세요.");
			return "haja/member/view";
		}
	}
	
	@RequestMapping("delete.do")
	public String delete(String userid, String passwd, 
			Model model, HttpSession session) {
		//비밀번호 check 
		boolean result = memberService.checkPw(userid, passwd);
		if(result) { //비밀번호가 맞으면
			//회원정보 수정
			memberService.deleteMember(userid);
			//수정한 후 홈으로 이동
			memberService.logout(session);
			return "redirect:/";
		} else {
			model.addAttribute("message", "비밀번호를 확인하세요.");
			model.addAttribute("dto", memberService.viewMember(userid));
			return "haja/member/view";
		}
	}
	
	@RequestMapping("admin_delete.do")
	public String admin_delete(String userid) {
		memberService.deleteMember(userid);
		return  "redirect:/member/admin.do";
	}
	
	// 아이디 찾기 
	@RequestMapping(value = "/find_id_form.do")
	public String find_id_form() throws Exception{
		return "haja/member/find_id_form";
	}
		
	// 아이디 찾기
	@RequestMapping(value = "/find_id.do", method = RequestMethod.POST)
	public String find_id(HttpServletResponse response, @RequestParam("email") String email, Model md) throws Exception{
		md.addAttribute("userid", memberService.find_id(response, email));
		return "haja/member/find_id";
	}
			
	// 비밀번호 찾기 
	@RequestMapping(value = "/find_pw_form.do")
	public String find_pw_form() throws Exception{
		return "haja/member/find_pw_form";
	}
			
	// 비밀번호 찾기
	@RequestMapping(value = "/find_pw.do", method = RequestMethod.POST)
	public String find_pw(HttpServletResponse response, @RequestParam("userid") String userid, @RequestParam("ssn1") String ssn1, @RequestParam("ssn2") String ssn2 , Model md) throws Exception{
		md.addAttribute("passwd", memberService.find_pw(response, userid,ssn1,ssn2));
		return "haja/member/find_pw";
	}
	
	//이메일 중복체크
	@ResponseBody
	@RequestMapping(value="/emailCheck", method = RequestMethod.POST)
	public int emailCheck(String email) throws Exception{
		int result = memberService.emailCheck(email);
		return result;
	}
	
	//아이디 중복체크
	@ResponseBody
	@RequestMapping(value="/idCheck", method = RequestMethod.POST)
	public int idCheck(String userid) throws Exception{
		int result = memberService.idCheck(userid);
		return result;
	}
}
