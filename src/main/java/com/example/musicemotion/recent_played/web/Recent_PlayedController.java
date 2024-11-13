package com.example.musicemotion.recent_played.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.musicemotion.dto.Recent_PlayedDTO;
import com.example.musicemotion.recent_played.service.Recent_PlayedService;
import com.example.musicemotion.spotify.service.SpotifyService;

import jakarta.servlet.http.HttpServletRequest;
import se.michaelthelin.spotify.model_objects.specification.Artist;
import se.michaelthelin.spotify.model_objects.specification.Track;

@Controller
@RequestMapping("/recentPlayed")
public class Recent_PlayedController {

	@Autowired
	Recent_PlayedService recent_PlayedService;
	
	@Autowired
	SpotifyService spotifyService;
	
	@PostMapping("/addRecentlyPlayed")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> addRecentlyPlayed(@RequestParam("musicId") String musicId) {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String username = authentication.getName();

	    Recent_PlayedDTO dto = new Recent_PlayedDTO();
	    dto.setUser_id(username);
	    dto.setSong_id(musicId);

	    recent_PlayedService.addRecent_Played(dto);

	    Map<String, Object> response = new HashMap<>();
	    response.put("success", true);
	    response.put("message", "최근 재생 목록에 추가되었습니다.");
	    return ResponseEntity.ok(response);
	}



	@GetMapping("/resentPlay.do")
	public String resentPlay(HttpServletRequest req) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        
        List<String> rlist = recent_PlayedService.recent_playedAll(username);
        
        int song_count = recent_PlayedService.getMonthlyPlayCount(username);
        req.setAttribute("song_count", song_count);
        
        String most_song = recent_PlayedService.getMostPlayedSongId(username);

        try {
			List<Track> track = spotifyService.getSongsByIds(rlist);
	        req.setAttribute("track", track);
	        
	        Track most_track = spotifyService.getTrack(most_song);
	        Artist artist = spotifyService.getArtistDetail(most_track.getArtists()[0].getId());
	        req.setAttribute("most_genre", artist.getGenres()[0]);
	        req.setAttribute("most_artist", most_track.getArtists()[0].getName());
		} catch (Exception e) {
			e.printStackTrace();
		}
        
		return "music/resentPlay";
	}
	
	@GetMapping("/topSongs.do")
    @ResponseBody
    public ResponseEntity<List<Map<String, Object>>> getTopPlayedSongs() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();

        List<Map<String, Object>> topSongs = recent_PlayedService.getTopPlayedSongs(username);
        System.out.println(topSongs);
        
        return ResponseEntity.ok(topSongs);
    }
}
