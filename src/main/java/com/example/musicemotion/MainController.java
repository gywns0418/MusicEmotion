package com.example.musicemotion;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.musicemotion.dto.EmotionDTO;
import com.example.musicemotion.emotion.service.EmotionService;
import com.example.musicemotion.spotify.service.SpotifyService;

import jakarta.servlet.http.HttpServletRequest;
import se.michaelthelin.spotify.model_objects.specification.Playlist;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;



@Controller
public class MainController {

	@Autowired
	EmotionService emotionService;
	
	@Autowired
	SpotifyService spotifyService;
	
    @RequestMapping(value="/")
    public String Home(HttpServletRequest req) {
    	List<EmotionDTO> emotion = emotionService.emotionAll();
    	req.setAttribute("emotion", emotion);
    	
        try {
        	List<String> genres = spotifyService.getAvailableGenres();
        	req.setAttribute("genres", genres);
            // 인기 플레이리스트를 가져와서 모델에 추가
            List<Playlist> popularPlaylists = spotifyService.getPopularPlaylists();
            req.setAttribute("popularPlaylists", popularPlaylists);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return "main";
    }
    

}
