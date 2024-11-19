package com.example.musicemotion.member.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
    
	
	 @GetMapping("/findId.do") 
	 public String findId(HttpServletRequest req) {
		 return "member/findid"; 
	 }
	/* 
	 * @PostMapping("/findid.do") public String findIdPro(HttpServletRequest
	 * req,MemberDTO member) { MemberDTO dto =
	 * memberService.findByName(member.getName()); req.setAttribute("member", dto);
	 * 
	 * return "member/findid_result"; }
	 */
	 @GetMapping("/updatePw.do") 
	 public String updatepw() { 
		 return "member/updatepw"; 
	 }
	 
    
	 @PostMapping("/mail.do")
	 public ResponseEntity<Map<String, Object>> sendMail(@RequestBody Map<String, String> requestData, HttpServletRequest req) {
	     String email = requestData.get("email");
	     String id = requestData.get("id");

	     // 6자리 랜덤 숫자 생성
	     Random rand = new Random();
	     int randomNum = rand.nextInt(900000) + 100000; // 100000(최소값)부터 999999(최대값) 사이의 숫자

	     HttpSession session = req.getSession();

	     // 세션에 랜덤 숫자 저장
	     session.setAttribute("randomNum", randomNum);
	     session.setAttribute("email", email);
	     session.setAttribute("id", id);
	     session.setAttribute("timestamp", System.currentTimeMillis()); // 현재 시간을 밀리초 단위로 저장

	     // 이메일 전송
	     memberService.sendSimpleEmail(email, "인증번호", "인증번호 : " + randomNum + "입니다.");

	     // 성공 응답 반환
	     Map<String, Object> response = new HashMap<>();
	     response.put("success", true);
	     return new ResponseEntity<>(response, HttpStatus.OK);
	 }

	 @PostMapping("/confirmCheckNumber.do")
	 public ResponseEntity<Map<String, Object>> confirmCheckNumber(@RequestBody Map<String, Object> requestData, HttpServletRequest req) {
	     int checkNumber = (int) requestData.get("code");
	     HttpSession session = req.getSession();
	     Integer sessionCheckNumber = (Integer) session.getAttribute("randomNum"); // Integer로 가져오기
	     Long timestamp = (Long) session.getAttribute("timestamp"); // 타임스탬프 가져오기

	     Map<String, Object> response = new HashMap<>();

	     // 세션에 값이 없는 경우
	     if (sessionCheckNumber == null || timestamp == null) {
	         response.put("success", false);
	         response.put("message", "인증번호가 유효하지 않습니다.");
	         return new ResponseEntity<>(response, HttpStatus.OK);
	     }

	     long currentTime = System.currentTimeMillis();
	     long elapsedTime = currentTime - timestamp; // 현재 시간과 저장된 시간의 차이

	     if (sessionCheckNumber == checkNumber) {
	         if (elapsedTime > 300000) { // 3분이 경과한 경우
	             response.put("success", false);
	             response.put("message", "인증번호가 만료되었습니다.");
	             return new ResponseEntity<>(response, HttpStatus.OK);
	         } else {
	             session.removeAttribute("randomNum");
	             session.removeAttribute("timestamp");
	             response.put("success", true);
	             return new ResponseEntity<>(response, HttpStatus.OK);
	         }
	     } else {
	         response.put("success", false);
	         response.put("message", "인증번호가 일치하지 않습니다.");
	         return new ResponseEntity<>(response, HttpStatus.OK);
	     }
	 }

	    @PostMapping("/resetPassword.do")
	    public ResponseEntity<Map<String, Object>> resetPassword(@RequestBody Map<String, String> requestData) {
	        Map<String, Object> response = new HashMap<>();

	        String email = requestData.get("email");
	        String newPassword = requestData.get("password");

	        try {
	            // 이메일을 통해 사용자를 조회
	            MemberDTO member = memberService.findByEmail(email);

	            if (member == null) {
	                response.put("success", false);
	                response.put("message", "유효하지 않은 이메일 주소입니다.");
	                return new ResponseEntity<>(response, HttpStatus.OK);
	            }

	            // 비밀번호 암호화 및 저장
	            String encodedPassword = memberService.encodePassword(newPassword);
	            member.setPassword(encodedPassword);
	            memberService.updateMember(member);

	            response.put("success", true);
	            return new ResponseEntity<>(response, HttpStatus.OK);

	        } catch (Exception e) {
	            response.put("success", false);
	            response.put("message", "비밀번호 재설정 중 오류가 발생했습니다.");
	            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    }
}
