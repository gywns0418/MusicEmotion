package com.example.musicemotion.member.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;

import com.example.musicemotion.dto.MemberDTO;

public class MemberService {
	private MemberDAO memberDAO;
	private final PasswordEncoder bcryptPasswordEncoder;

	public MemberService(PasswordEncoder bcryptPasswordEncoder) {
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;
    }
	
	@Transactional
	public void signupPro(MemberDTO member) {
		member.setGrade("ROLE_1");
		member.setPassword(bcryptPasswordEncoder.encode(member.getPassword()));
		memberDAO.signupPro(member);
	}
}
