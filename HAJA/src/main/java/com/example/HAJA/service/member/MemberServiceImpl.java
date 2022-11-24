package com.example.HAJA.service.member;

import java.io.PrintWriter;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.example.HAJA.model.member.dao.AlarmDAO;
import com.example.HAJA.model.member.dao.MemberDAO;
import com.example.HAJA.model.member.dao.MessageDAO;
import com.example.HAJA.model.member.dto.MemberDTO;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Inject
	MemberDAO memberDao;
	
	@Inject
	AlarmDAO alarmDao;
	
	@Inject
	MessageDAO messageDao;

	@Override
	public String login_check(MemberDTO dto, HttpSession session) throws Exception {
	String name = memberDao.login_check(dto);
	 if (name != null) { // 세션 변수 저장
		 dto = memberDao.viewMember(dto.getUserid());
		 String userid = dto.getUserid();
		 session.setAttribute("userid", userid);
		 session.setAttribute("teamid", dto.getTeamid());
		 session.setAttribute("isadmin", dto.getIsadmin());
		 session.setAttribute("alarmNviewCnt", alarmDao.countNview(userid));
		 // session.setAttribute("alarmList3", alarmDao.list3(userid));
		 session.setAttribute("messageNviewCnt", messageDao.countNview(userid));
		 // session.setAttribute("messageList3", messageDao.list3(userid));
	}
	 return name; 
	}

	@Override
	public void logout(HttpSession session) {
		// 세션 초기화
		session.invalidate();
	}

	@Override
	public MemberDTO viewMember(String userid) {
		return memberDao.viewMember(userid);
	}

	@Override
	public List<MemberDTO> list(int start, int end, String keyword) {
		return memberDao.list(start, end, keyword);
	}

	@Override
	public void insertMember(MemberDTO dto) {
		memberDao.insertMember(dto);
	}

	@Override
	public boolean checkPw(String userid, String passwd) {
		return memberDao.checkPw(userid,passwd);
	}

	@Override
	public void updateMember(MemberDTO dto) {
		memberDao.updateMember(dto);
	}

	@Override
	public void deleteMember(String userid) {
		memberDao.deleteMember(userid);
	}

	@Override
	public String find_id(HttpServletResponse response, String email) throws Exception {
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		String id = memberDao.find_id(email);
		
		if (id == null) {
			out.println("<script>");
			out.println("alert('가입된 아이디가 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else {
			return id;
		}
	}

	@Override
	public Object find_pw(HttpServletResponse response1, String userid, String ssn1, String ssn2) {
		response1.setContentType("text/html;charset=utf-8");
		String pw = memberDao.find_pw(userid,ssn1,ssn2);

			return pw;
	}
	
	@Override
	public int emailCheck(String email) throws Exception {
		int result = memberDao.emailCheck(email);
		return result;
	}
	
	@Override
	public int idCheck(String userid) throws Exception {
		int result = memberDao.idCheck(userid);
		return result;
	}

	@Override
	public int countMember() {
		return memberDao.countMember();
	}
}
