package com.example.musicemotion.member.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.musicemotion.dto.CustomMemberDetails;
import com.example.musicemotion.dto.MemberDTO;


@Repository
public class MemberDAO {
	
	 @Autowired
	 private SqlSession sqlSession;
	 
	 public void signupPro(MemberDTO member) {
		 sqlSession.insert("member.signupPro", member);
	 }
	 
	 public CustomMemberDetails findById(String user_id) {
		 return sqlSession.selectOne("member.findById", user_id);
	 }
	 
	 public MemberDTO findEdit(String user_id){
		 return sqlSession.selectOne("findEdit", user_id);
	 }
	 
	 public String findPasswordByUserId(String user_id){
		 return sqlSession.selectOne("findPasswordByUserId", user_id);
	 }
}
