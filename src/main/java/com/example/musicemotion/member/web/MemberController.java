package com.example.musicemotion.member.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.musicemotion.dto.MemberDTO;
import com.example.musicemotion.dto.PlaylistDTO;
import com.example.musicemotion.member.service.MemberDAO;
import com.example.musicemotion.member.service.MemberService;
import com.example.musicemotion.playList.service.PlaylistService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberDAO memberDAO;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	PlaylistService playlistService;
	
	@GetMapping("/myPage.do")
	public String myPage(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
		
        List<PlaylistDTO> plist = playlistService.playlistAll(username);
        req.setAttribute("plist", plist);
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
	
	@GetMapping("/myEdit.do")
	public String myEdit(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        
        MemberDTO member = memberDAO.findEdit(username);
        req.setAttribute("member", member);
		return "member/myEdit";
	}
	
	@PostMapping("/myEdit.do")
	public String myEdit(MemberDTO member) {
		
		memberService.signupPro(member);
		return "redirect:/member/mypage.do";
	}
	
    @PostMapping("/checkPassword")
    @ResponseBody
    public boolean checkPassword(@RequestParam("userId") String userId,
                                     @RequestParam("inputPassword") String inputPassword) {
        boolean encryptedPassword = memberService.isPasswordMatching(userId,inputPassword);
        return encryptedPassword;
    }
}
