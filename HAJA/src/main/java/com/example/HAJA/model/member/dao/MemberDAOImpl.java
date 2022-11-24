package com.example.HAJA.model.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.example.HAJA.model.member.dto.MemberDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Inject
	SqlSession sqlSession;

	@Override
	public String login_check(MemberDTO dto) {
		return sqlSession.selectOne("member.login_check",dto);
	}

	@Override
	public MemberDTO viewMember(String userid) {
		return sqlSession.selectOne("member.viewMember", userid);
	}

	@Override
	public List<MemberDTO> list(int start, int end, String keyword) {
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("keyword", "%"+keyword+"%");
		return sqlSession.selectList("member.memberList", map);
	}

	@Override
	public void insertMember(MemberDTO dto) {
		sqlSession.insert("member.insertMember", dto);
	}

	@Override
	public boolean checkPw(String userid, String passwd) {
		boolean result = false;
		//불린값은 항상 초기값을 false로 
		Map<String, String> map = new HashMap<>();
		map.put("userid", userid);
		map.put("passwd", passwd);
		int count = sqlSession.selectOne("member.checkPw",map);
		//비밀번호가 맞으면 (1) 리턴 틀리면 (0)
		if(count == 1) result = true;
		
		return result;
	}

	@Override
	public void updateMember(MemberDTO dto) {
		sqlSession.update("member.updateMember",dto);
	}

	@Override
	public void deleteMember(String userid) {
		sqlSession.delete("member.deleteMember", userid);
	}
	
	@Override
	public String find_id(String email) throws Exception{
		return sqlSession.selectOne("member.find_id", email);
	}

	@Override
	public String find_pw(String userid, String ssn1, String ssn2)  {
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("ssn1", ssn1);
		map.put("ssn2", ssn2);
		
		return sqlSession.selectOne("member.find_pw", map);
	}
	
	@Override
	public int emailCheck(String email) throws Exception {
		return sqlSession.selectOne("member.emailCheck", email);
	}
	
	@Override
	public int idCheck(String userid) throws Exception {
		return sqlSession.selectOne("member.idCheck", userid);
	}

	@Override
	public int countMember() {
		return sqlSession.selectOne("countMember");
	}
}
