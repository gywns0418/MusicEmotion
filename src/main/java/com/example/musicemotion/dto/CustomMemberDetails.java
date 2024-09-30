package com.example.musicemotion.dto;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;


public class CustomMemberDetails implements UserDetails{
	private String user_id;
	private String password;
	private String user_name;
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
		return user_id;
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
		return user_name;
	}

	public void setName(String name) {
		this.user_name = name;
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
