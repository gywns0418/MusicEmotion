package com.example.musicemotion.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.musicemotion.dto.MemberDTO;

@Service
public class MemberService {
    
    private final MemberDAO memberDAO; // MemberDAO 필드 추가
    private final PasswordEncoder bcryptPasswordEncoder;

    @Autowired
    public MemberService(MemberDAO memberDAO, PasswordEncoder bcryptPasswordEncoder) {
        this.memberDAO = memberDAO; // DAO 주입
        this.bcryptPasswordEncoder = bcryptPasswordEncoder;
    }
    
    @Transactional
    public void signupPro(MemberDTO member) {
        member.setGrade("ROLE_1");
        member.setPassword(bcryptPasswordEncoder.encode(member.getPassword()));
        memberDAO.signupPro(member);
    }
}
