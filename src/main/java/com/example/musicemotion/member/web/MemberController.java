package com.example.musicemotion.member.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@GetMapping("/myPage.do")
	public String myPage() {
		return "member/myPage";
	}
	
	@GetMapping("/login.do")
	public String login() {
		return "member/login";
	}


	@GetMapping("/signUp.do")
	public String signUp() {
		return "member/signUp";
	}
}
