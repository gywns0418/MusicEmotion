package com.example.musicemotion.member.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.musicemotion.dto.MemberDTO;
import com.example.musicemotion.member.service.MemberService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
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
	
	@PostMapping("/signUpPro.do")
	public String signUpFin(MemberDTO member) {
		memberService.signupPro(member);
		return "redirect:/member/login.do";
	}
}
