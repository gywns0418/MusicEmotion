package com.example.musicemotion.spotify.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.musicemotion.spotify.service.SpotifyService;

import jakarta.servlet.http.HttpServletRequest;
import se.michaelthelin.spotify.model_objects.specification.Album;
import se.michaelthelin.spotify.model_objects.specification.Artist;
import se.michaelthelin.spotify.model_objects.specification.AudioFeatures;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.model_objects.specification.PlaylistTrack;
import se.michaelthelin.spotify.model_objects.specification.Recommendations;
import se.michaelthelin.spotify.model_objects.specification.Track;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/spotify")
public class SpotifyController {

    private final SpotifyService spotifyService;

    @Autowired
    public SpotifyController(SpotifyService spotifyService) {
        this.spotifyService = spotifyService;
    }

    @GetMapping("/audio-features/{trackId}")
    public AudioFeatures getAudioFeatures(@PathVariable String trackId) 
    		throws Exception {
        return spotifyService.getAudioFeaturesForTrack(trackId);
    }
    
    @GetMapping("/recommended-tracks")
    public Recommendations getRecommendedTracks() 
    		throws Exception {
        return spotifyService.getRecommendedTracks();
    }
    
	@GetMapping("/musicDetail.do")
	public String musicDetail(HttpServletRequest req) {
        try {
            String trackId = "3n3Ppam7vgaVa1iaRUc9Lp";
            String albumId = "6akEvsycLGftJxYudPjmqK";
            String artistId = "0OdUWJ0sBjDrqHygGUXeCF";

            // 트랙 정보 가져오기
            Track track = spotifyService.getTrack(trackId);
            req.setAttribute("albumImage", track.getAlbum().getImages()[0].getUrl());
            req.setAttribute("trackName", track.getName());
            req.setAttribute("trackDuration", track.getDurationMs());
            req.setAttribute("trackPopularity", track.getPopularity());

            // 앨범 정보 가져오기
            Album album = spotifyService.getAlbumDetail(albumId);
            req.setAttribute("albumName", album.getName());
            req.setAttribute("albumReleaseDate", album.getReleaseDate());
            req.setAttribute("albumTotalTracks", album.getTracks());

            // 아티스트 정보 가져오기
            Artist artist = spotifyService.getArtistDetail(artistId);
            req.setAttribute("artistName", artist.getName());
            req.setAttribute("artistPopularity", artist.getPopularity());
            req.setAttribute("artistFollowers", artist.getFollowers().getTotal());

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		return "music/musicDetail";
	}
	
	@GetMapping("/musicList.do")
	public String musicList(HttpServletRequest req, @RequestParam(value = "search", required = false) String search) {
	    try {
	        // search 파라미터가 있는 경우 검색 수행
	        if (search != null && !search.isEmpty()) {
	            Track[] tracks = spotifyService.searchTracks(search);
	            req.setAttribute("tracks", tracks);
	        } else {
	            // 기본 트랙 정보를 가져와서 설정
	            String trackId = "3n3Ppam7vgaVa1iaRUc9Lp";  
	            Track track = spotifyService.getTrack(trackId);

	            req.setAttribute("trackName", track.getName());
	            req.setAttribute("albumImage", track.getAlbum().getImages()[0].getUrl());
	            req.setAttribute("artistName", track.getArtists()[0].getName());
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    
	    return "music/musicList";
	}





	@GetMapping("/resentPlay.do")
	public String resentPlay() {
		return "music/resentPlay";
	}
	

}
