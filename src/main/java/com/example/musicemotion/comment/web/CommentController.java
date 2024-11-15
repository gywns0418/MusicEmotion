package com.example.musicemotion.comment.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.musicemotion.comment.service.CommentService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/comment")
public class CommentController {

	@Autowired
	CommentService commentService;


	@PostMapping("/addComment.do")
	public String addComment(HttpServletRequest req) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        
        String redirectUrl = req.getParameter("redirectUrl");

		return "redirect:"+redirectUrl;
	}

}
