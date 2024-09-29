package com.example.musicemotion.dto;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class CustomMemberDetails implements UserDetails{
	private String memberID;
	private String password;
	private String name;
	private String profile;
	private String authority;
	private boolean enabled;
	
	
	/*
	 * public CustomMemberDetails(String memberID, String password, String name,
	 * String authority, boolean enabled) { this.memberID = memberID; this.password
	 * = password; this.name = name; this.authority = authority; this.enabled =
	 * enabled; }
	 */
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		ArrayList<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();
		auth.add(new SimpleGrantedAuthority(authority));
		return auth;
		 //return Collections.singletonList(new SimpleGrantedAuthority(authority));
	}
	
	@Override
	public String getPassword() {
		return password;
	}
	
	@Override
	public String getUsername() {
		return memberID;
	}
	
	
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	
	@Override
	public boolean isEnabled() {
		return enabled;
	}
	
	public String getName() {
		return name;
	}

	public void setNAME(String name) {
		this.name = name;
	}
	public void setAuthority(String authority) {
        this.authority = authority;
    }

	public String getProfile() {
		return profile;
	}

	public void setProfile(String profile) {
		this.profile = profile;
	}

}
