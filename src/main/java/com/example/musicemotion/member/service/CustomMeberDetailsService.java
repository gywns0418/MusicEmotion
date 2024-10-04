package com.example.musicemotion.member.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.musicemotion.dto.CustomMemberDetails;


@Service
public class CustomMeberDetailsService implements UserDetailsService{
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Override
	public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {
	    CustomMemberDetails member = memberDAO.findById(userId);
	    System.out.println("Member found: " + member);
	    
	    if (member == null) {
	        throw new UsernameNotFoundException("User not found with userId: " + userId);
	    }
	    
	    String enteredPassword = "dd";
	    boolean passwordMatches = bCryptPasswordEncoder.matches(enteredPassword, member.getPassword());
	    System.out.println("Password matches: " + passwordMatches);
	    
	    // 여기에 비밀번호 확인 로그 추가
	    System.out.println("Password from DB: " + member.getPassword()); // 암호화된 비밀번호 출력
	    System.out.println("Auth from DB: " + member.getAuthorities()); 
	    
	    return member;
	}
}

