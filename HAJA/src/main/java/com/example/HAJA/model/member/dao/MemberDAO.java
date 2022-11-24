package com.example.HAJA.model.member.dao;

import java.util.List;

import com.example.HAJA.model.member.dto.MemberDTO;

public interface MemberDAO {
	public String login_check(MemberDTO dto);
	public MemberDTO viewMember(String userid);
	public List<MemberDTO> list(int start, int end, String keyword);
	public void insertMember(MemberDTO dto);
	public boolean checkPw(String userid, String passwd);
	public void updateMember(MemberDTO dto);
	public void deleteMember(String userid);
	public String find_id(String email) throws Exception;
	public String find_pw(String userid, String ssn1, String ssn2);
	public int emailCheck(String email) throws Exception;
	public int idCheck(String userid) throws Exception;
	public int countMember();
}
