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
import org.springframework.stereotype.Service;

import com.example.musicemotion.dto.CustomMemberDetails;


@Service
public class CustomMeberDetailsService implements UserDetailsService{
	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		
		CustomMemberDetails user = memberDAO.findById(username);

		if(user==null) {
			throw new UsernameNotFoundException(username);
		}
		
		
		return new User(user.getUsername(), user.getPassword(), user.getAuthorities());
	}
}
