package com.example.musicemotion.likes.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
        
    	List<String> likedSongIds = likesService.likesAll(username);
    	req.setAttribute("likedSongIds", likedSongIds);
    	
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
	
	@PostMapping("/addLike")
	@ResponseBody
	public Map<String, Object> addLike(@RequestBody Map<String, Object> likeData) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        
	    String songId = (String) likeData.get("song_id");
	    boolean isLiked = (Boolean) likeData.get("liked");

        LikesDTO like = new LikesDTO();
        like.setUser_id(username);
        like.setSong_id(songId);
        
	    // 좋아요 상태에 따라 삽입 또는 삭제 처리
	    if (isLiked) {
	        likesService.addLikes(like);
	    } else {
	    	likesService.deleteLikes(like); // 좋아요 해제 로직
	    }

	    // 결과를 JSON 형태로 응답
	    Map<String, Object> response = new HashMap<>();
	    response.put("success", true);
	    return response;
	}

}
