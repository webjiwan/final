package com.example.HAJA.service.member;

import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.example.HAJA.model.member.dto.MemberDTO;

public interface MemberService {
	public String login_check(MemberDTO dto, HttpSession session) throws Exception;
	public void logout(HttpSession session);
	public MemberDTO viewMember(String userid);
	public List<MemberDTO> list(int start, int end, String keyword);
	public void insertMember(MemberDTO dto);
	public boolean checkPw(String userid, String passwd);
	public void updateMember(MemberDTO dto);
	public void deleteMember(String userid);
	public String find_id(HttpServletResponse response, String email) throws Exception;
	public Object find_pw(HttpServletResponse response, String userid, String ssn1, String ssn2);
	public int emailCheck(String email) throws Exception;
	public int idCheck(String userid) throws Exception;
	public int countMember();
}
