package com.example.musicemotion.playList.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.musicemotion.dto.PlaylistDTO;
import com.example.musicemotion.playList.service.PlaylistService;
import com.example.musicemotion.spotify.service.SpotifyService;

import jakarta.servlet.http.HttpServletRequest;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.model_objects.specification.PlaylistTrack;
import se.michaelthelin.spotify.model_objects.specification.Recommendations;

@Controller
@RequestMapping("/playlist")
public class PlayListController {
	
	@Autowired
	SpotifyService spotifyService;
	
	@Autowired
	PlaylistService playlistService;
	
	@GetMapping("/playListMain.do")
	public String playListMain(HttpServletRequest req) throws Exception {	//@RequestParam String genre, @RequestParam(defaultValue = "10") int limit
        String  genre = "pop";  // 임의의 장르 값
        int limit = 1;  // 가져올 인기 플레이리스트 수
        int trackLimit = 20; // 각 플레이리스트에서 가져올 트랙 수 제한

        try {
            PlaylistSimplified[] featuredPlaylists = spotifyService.getFeaturedPlaylists(limit);
            Map<String, PlaylistTrack[]> playlistTracks = new HashMap<>();

            for (PlaylistSimplified playlist : featuredPlaylists) {
                String playlistId = playlist.getId();
                PlaylistTrack[] tracks = spotifyService.getPlaylistTracks(playlistId, trackLimit); // 트랙 수 제한 적용
                playlistTracks.put(playlist.getName(), tracks);
            }
            
        	Recommendations recommendations = spotifyService.getRecommendations(genre, limit);
        	
        	req.setAttribute("playlistTracks", playlistTracks);
        } catch (IOException | SpotifyWebApiException e) {
            e.printStackTrace();
            return null;
        }
        
		return "music/playListMain";
	}
	
	@PostMapping("/addPlaylist.do")
	public String addPlaylist(PlaylistDTO dto) {
		
		playlistService.addPlaylist(dto);
		return "redirect:/member/myPage.do";
	}
}
