package com.example.musicemotion.recent_played.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.musicemotion.dto.Recent_PlayedDTO;
import com.example.musicemotion.recent_played.service.Recent_PlayedService;

@Controller
@RequestMapping("/recentPlayed")
public class Recent_PlayedController {

	@Autowired
	Recent_PlayedService recent_PlayedService;
	
	@PostMapping("/addRecentlyPlayed")
	public ResponseEntity<String> addRecentlyPlayed(@RequestParam("musicId") String musicId) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        
		Recent_PlayedDTO dto = new Recent_PlayedDTO();
		dto.setUser_id(username);
		dto.setSong_id(musicId);
		
		recent_PlayedService.addRecent_Played(dto);
	    return ResponseEntity.ok("최근 재생 목록에 추가되었습니다.");
	}

	
}
