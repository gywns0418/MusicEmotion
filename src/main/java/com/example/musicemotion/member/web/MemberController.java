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
	 
	 @PostMapping("/findId")
	    public ResponseEntity<?> findId(@RequestBody Map<String, String> request,HttpServletRequest req) {
	        String name = request.get("name");
	        String email = request.get("email");
	        
	        MemberDTO dto = new MemberDTO();
	        dto.setUser_name(name);
	        dto.setEmail(email);
	        
		     Random rand = new Random();
		     int randomNum = rand.nextInt(900000) + 100000;
		     
		     HttpSession session = req.getSession();

	        try {
	            String userId = memberDAO.findIdByNameAndEmail(dto);
	            if (userId != null) {
	       	     	session.setAttribute("randomNum", randomNum);
	       	     	session.setAttribute("timestamp", System.currentTimeMillis());
	                memberService.sendSimpleEmail(email, "인증번호", "인증번호 : " + randomNum + "입니다.");
	                return ResponseEntity.ok(Map.of(
	                    "success", true,
	                    "message", "인증번호가 발송되었습니다."
	                ));
	            } else {
	                return ResponseEntity.ok(Map.of("success", false, "message", "해당 정보로 등록된 아이디가 없습니다."));
	            }
	        } catch (Exception e) {
	            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                    .body(Map.of("success", false, "message", "서버 오류가 발생했습니다."));
	        }
	    }
     
	 @PostMapping("/checkNumber.do")
	 public ResponseEntity<Map<String, Object>> checkNumber(@RequestBody Map<String, Object> requestData, HttpServletRequest req) {
	     Map<String, Object> response = new HashMap<>();

	     try {
	         // 요청 데이터에서 인증번호 가져오기
	         if (!requestData.containsKey("code") || !requestData.containsKey("email")) {
	             response.put("success", false);
	             response.put("message", "이메일 또는 인증번호가 누락되었습니다.");
	             return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
	         }

	         String email = requestData.get("email").toString();
	         int checkNumber;
	         try {
	             checkNumber = Integer.parseInt(requestData.get("code").toString());
	         } catch (NumberFormatException e) {
	             response.put("success", false);
	             response.put("message", "인증번호가 올바른 형식이 아닙니다.");
	             return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
	         }

	         // 세션에서 저장된 인증번호 가져오기
	         HttpSession session = req.getSession();
	         Integer sessionCheckNumber = (Integer) session.getAttribute("randomNum");
	         Long timestamp = (Long) session.getAttribute("timestamp");

	         if (sessionCheckNumber == null || timestamp == null) {
	             response.put("success", false);
	             response.put("message", "인증번호가 유효하지 않습니다. 다시 요청해주세요.");
	             return new ResponseEntity<>(response, HttpStatus.OK);
	         }

	         long currentTime = System.currentTimeMillis();
	         long elapsedTime = currentTime - timestamp;

	         // 인증번호 확인
	         if (sessionCheckNumber.equals(checkNumber)) {
	             if (elapsedTime > 300000) { // 5분(300,000ms) 초과
	                 response.put("success", false);
	                 response.put("message", "인증번호가 만료되었습니다.");
	                 return new ResponseEntity<>(response, HttpStatus.OK);
	             } else {
	                 // 인증 성공: 세션 데이터 제거
	                 session.removeAttribute("randomNum");
	                 session.removeAttribute("timestamp");

	                 // 아이디 조회
	                 MemberDTO member = memberDAO.findByEmail(email);
	                 if (member == null) {
	                     response.put("success", false);
	                     response.put("message", "해당 이메일로 등록된 아이디가 없습니다.");
	                     return new ResponseEntity<>(response, HttpStatus.OK);
	                 }

	                 // 이메일로 아이디 발송
	                 String userId = member.getUser_id();
	                 memberService.sendSimpleEmail(email, "아이디 정보", "회원님의 아이디는: " + userId + " 입니다.");

	                 response.put("success", true);
	                 response.put("message", "인증이 완료되었습니다. 아이디를 이메일로 발송했습니다.");
	                 return new ResponseEntity<>(response, HttpStatus.OK);
	             }
	         } else {
	             response.put("success", false);
	             response.put("message", "인증번호가 일치하지 않습니다.");
	             return new ResponseEntity<>(response, HttpStatus.OK);
	         }
	     } catch (Exception e) {
	         response.put("success", false);
	         response.put("message", "서버 오류가 발생했습니다. 관리자에게 문의하세요.");
	         e.printStackTrace();
	         return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	     }
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
	     Map<String, Object> response = new HashMap<>();
	     try {
	         // 요청 데이터에서 인증번호 가져오기
	         if (!requestData.containsKey("code")) {
	             response.put("success", false);
	             response.put("message", "인증번호가 요청에 포함되지 않았습니다.");
	             return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
	         }

	         int checkNumber;
	         try {
	             checkNumber = Integer.parseInt(requestData.get("code").toString());
	         } catch (NumberFormatException e) {
	             response.put("success", false);
	             response.put("message", "인증번호가 올바른 형식이 아닙니다.");
	             return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
	         }

	         // 세션에서 저장된 인증번호와 타임스탬프 가져오기
	         HttpSession session = req.getSession();
	         Integer sessionCheckNumber = (Integer) session.getAttribute("randomNum");
	         Long timestamp = (Long) session.getAttribute("timestamp");

	         if (sessionCheckNumber == null || timestamp == null) {
	             response.put("success", false);
	             response.put("message", "인증번호가 유효하지 않습니다. 다시 요청해주세요.");
	             return new ResponseEntity<>(response, HttpStatus.OK);
	         }

	         long currentTime = System.currentTimeMillis();
	         long elapsedTime = currentTime - timestamp;

	         // 인증번호 확인 로직
	         if (sessionCheckNumber.equals(checkNumber)) {
	             if (elapsedTime > 300000) { // 5분(300,000ms)이 초과된 경우
	                 response.put("success", false);
	                 response.put("message", "인증번호가 만료되었습니다.");
	                 return new ResponseEntity<>(response, HttpStatus.OK);
	             } else {
	                 // 인증 성공 시 세션 데이터 제거
	                 session.removeAttribute("randomNum");
	                 session.removeAttribute("timestamp");
	                 response.put("success", true);
	                 response.put("message", "인증번호가 확인되었습니다.");
	                 return new ResponseEntity<>(response, HttpStatus.OK);
	             }
	         } else {
	             response.put("success", false);
	             response.put("message", "인증번호가 일치하지 않습니다.");
	             return new ResponseEntity<>(response, HttpStatus.OK);
	         }
	     } catch (Exception e) {
	         // 예외 발생 시 처리
	         response.put("success", false);
	         response.put("message", "서버 오류가 발생했습니다. 관리자에게 문의하세요.");
	         e.printStackTrace(); // 로그에 예외 출력
	         return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	     }
	 }


	    @PostMapping("/resetPassword.do")
	    public ResponseEntity<Map<String, Object>> resetPassword(@RequestBody Map<String, String> requestData) {
	        Map<String, Object> response = new HashMap<>();

	        String email = requestData.get("email");
	        String newPassword = requestData.get("password");
	        String id = requestData.get("id");

	        try {
	            // 이메일을 통해 사용자를 조회
	            MemberDTO member = memberDAO.findByEmail(email);

	            if (member == null) {
	                response.put("success", false);
	                response.put("message", "유효하지 않은 이메일 주소입니다.");
	                return new ResponseEntity<>(response, HttpStatus.OK);
	            }

	            // 비밀번호 암호화 및 저장
	            String encodedPassword = memberService.encodePassword(newPassword);
	            member.setPassword(encodedPassword);
	            member.setUser_id(id);
	            System.out.println("newPassword : "+newPassword+" id : "+id);
	            memberDAO.updatePw(member);

	            response.put("success", true);
	            return new ResponseEntity<>(response, HttpStatus.OK);

	        } catch (Exception e) {
	            response.put("success", false);
	            response.put("message", "비밀번호 재설정 중 오류가 발생했습니다.");
	            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
	        }
	    }
}
