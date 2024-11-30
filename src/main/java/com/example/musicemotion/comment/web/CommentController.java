package com.example.musicemotion.comment.web;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.musicemotion.comment.service.CommentService;
import com.example.musicemotion.dto.CommentsDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/comment")
public class CommentController {

	@Autowired
	CommentService commentService;


	@PostMapping("/addCommu.do")
	public ResponseEntity<String> addComment(@RequestBody Map<String, Object> params) {
	    Integer referenceId = Integer.parseInt(params.get("referenceId").toString());
	    String type = (String) params.get("type");
	    String memberName = (String) params.get("memberName");
	    String content = (String) params.get("content");

	    System.out.println("Reference ID: " + referenceId);
	    System.out.println("Type: " + type);
	    System.out.println("Member Name: " + memberName);
	    System.out.println("Content: " + content);

	    try {
	        CommentsDTO dto = new CommentsDTO();
	        dto.setMember_name(memberName);
	        dto.setReference_id(referenceId);
	        dto.setType(type);
	        dto.setContent(content);

	        // 서비스 호출
	        commentService.addComments(dto);

	        return ResponseEntity.ok("success");
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
	    }
	}
	
	@PostMapping("/addNotice.do")
	public ResponseEntity<String> addNotice(@RequestBody Map<String, Object> params) {
	    Integer referenceId = Integer.parseInt(params.get("referenceId").toString());
	    String type = (String) params.get("type");
	    String memberName = (String) params.get("memberName");
	    String content = (String) params.get("content");

	    System.out.println("Reference ID: " + referenceId);
	    System.out.println("Type: " + type);
	    System.out.println("Member Name: " + memberName);
	    System.out.println("Content: " + content);

	    try {
	        CommentsDTO dto = new CommentsDTO();
	        dto.setMember_name(memberName);
	        dto.setReference_id(referenceId);
	        dto.setType(type);
	        dto.setContent(content);

	        // 서비스 호출
	        commentService.addComments(dto);

	        return ResponseEntity.ok("success");
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
	    }
	}


}
