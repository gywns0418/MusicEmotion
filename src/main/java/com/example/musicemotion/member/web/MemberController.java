package com.example.musicemotion.member.web;

import java.util.List;
import java.util.Random;

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
import jakarta.servlet.http.HttpSession;

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
    
	/*
	 * @GetMapping("/findid.do") public String findId(HttpServletRequest req) {
	 * return "member/findid"; }
	 * 
	 * @PostMapping("/findid.do") public String findIdPro(HttpServletRequest
	 * req,MemberDTO member) { MemberDTO dto =
	 * memberService.findByName(member.getName()); req.setAttribute("member", dto);
	 * 
	 * return "member/findid_result"; }
	 * 
	 * @GetMapping("/updatepw.do") public String updatepw() { return
	 * "member/updatepw"; }
	 * 
	 * @PostMapping("/updatepw.do") public String updatepwView(HttpServletRequest
	 * req, MemberDTO member) { MemberDTO dto = memberService.findByIdName(member);
	 * req.setAttribute("member", dto); return "member/updatePro"; }
	 * 
	 * @PostMapping("/updatepwPro.do") public String updatePwPro(MemberDTO member) {
	 * memberservice.updatePw(member); return "redirect:/index.do"; }
	 */
    
    @PostMapping("/mail.do")
    public String sendMail(String email,String id, HttpServletRequest req) {
        // 6자리 랜덤 숫자 생성
        Random rand = new Random();
        int randomNum = rand.nextInt(900000) + 100000;  // 100000(최소값)부터 999999(최대값) 사이의 숫자
        
        HttpSession session = req.getSession();

        // 세션에 랜덤 숫자 저장
        session.setAttribute("randomNum", randomNum);
        session.setAttribute("email",email);
        session.setAttribute("id",id);
        session.setAttribute("timestamp", System.currentTimeMillis()); // 현재 시간을 밀리초 단위로 저장


        // 이메일 전송
        memberService.sendSimpleEmail(email, "인증번호", "인증번호 : " + randomNum + "입니다.");
        return "checkMe";
    }
}
