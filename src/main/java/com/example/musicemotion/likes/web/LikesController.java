package com.example.musicemotion.likes.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.musicemotion.dto.LikesDTO;
import com.example.musicemotion.likes.service.LikesService;
import com.example.musicemotion.spotify.service.SpotifyService;

import jakarta.servlet.http.HttpServletRequest;
import se.michaelthelin.spotify.model_objects.specification.Track;

@Controller
@RequestMapping("/likes")
public class LikesController {
	
	@Autowired
	SpotifyService spotifyService;
	
	@Autowired
	LikesService likesService;
	
	@GetMapping("/likes.do")
	public String likes(HttpServletRequest req) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        
        try {
            // DB에서 song_id 리스트 가져오기
            List<String> songIds = likesService.likesAll(username);

            // Spotify API로 곡 정보 가져오기
            List<Track> songs = spotifyService.getSongsByIds(songIds);

            // JSP로 곡 정보 전달
            req.setAttribute("songs", songs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
		return "music/likes";
	}
}
