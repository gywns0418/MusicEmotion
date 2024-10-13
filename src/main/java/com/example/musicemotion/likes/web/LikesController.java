package com.example.musicemotion.likes.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/likes")
public class LikesController {
	
	@GetMapping("/likes.do")
	public String likes() {
		return "music/likes";
	}
}
