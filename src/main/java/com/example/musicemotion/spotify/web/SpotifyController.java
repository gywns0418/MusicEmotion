package com.example.musicemotion.spotify.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.musicemotion.likes.service.LikesService;
import com.example.musicemotion.musixmatch.service.MusixmatchService;
import com.example.musicemotion.spotify.service.SpotifyService;

import jakarta.servlet.http.HttpServletRequest;
import se.michaelthelin.spotify.model_objects.specification.Album;
import se.michaelthelin.spotify.model_objects.specification.Artist;
import se.michaelthelin.spotify.model_objects.specification.ArtistSimplified;
import se.michaelthelin.spotify.model_objects.specification.AudioFeatures;
import se.michaelthelin.spotify.model_objects.specification.PlaylistSimplified;
import se.michaelthelin.spotify.model_objects.specification.PlaylistTrack;
import se.michaelthelin.spotify.model_objects.specification.Recommendations;
import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.model_objects.specification.TrackSimplified;

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
	LikesService likesService;
    
	@Autowired
	MusixmatchService musixmatchService;

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
	public String musicDetail(HttpServletRequest req,@RequestParam String song_id) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        
    	List<String> likedSongIds = likesService.likesAll(username);
    	req.setAttribute("likedSongIds", likedSongIds);
    	
        try {
            String trackId = song_id;
            Track track = spotifyService.getTrack(trackId);
            
            Album album = spotifyService.getAlbumDetail(track.getAlbum().getId());
            String releaseDate = album.getReleaseDate();
            ArtistSimplified[] artists = album.getArtists();
            
            List<String> artistNames = new ArrayList<>();
            for (ArtistSimplified artist : artists) {
                artistNames.add(artist.getName());
            }
            
            Artist artist = spotifyService.getArtistDetail(track.getArtists()[0].getId());
            String[] genre = artist.getGenres();
            

            req.setAttribute("albumImage", track.getAlbum().getImages()[0].getUrl());
            req.setAttribute("trackName", track.getName());
            req.setAttribute("artistName", track.getArtists()[0].getName());
            req.setAttribute("artistNames", artistNames);
            req.setAttribute("genre", genre[0]);
            req.setAttribute("releaseDate", releaseDate);
            req.setAttribute("track", track);

            
            String lyrics = musixmatchService.getLyricsByTrackName(track.getName(),track.getArtists()[0].getName());

            System.out.println("가사 정보2: " + lyrics);
            
            if (lyrics != null) {
                // "******* This Lyrics is NOT for Commercial use *******" 부분 제거
                lyrics = lyrics.replace("******* This Lyrics is NOT for Commercial use *******", "");

                // 줄바꿈 문자(\n)를 <br>로 변환
                lyrics = lyrics.replace("\n", "<br>");
            }
            req.setAttribute("lyrics", lyrics);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
		return "music/musicDetail";
	}
	
    @GetMapping("/musicList.do")
    public String musicList(HttpServletRequest req, @RequestParam(value = "search", required = false) String search) {
    	
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        
    	List<String> likedSongIds = likesService.likesAll(username);
    	req.setAttribute("likedSongIds", likedSongIds);
    	
        try {
            if (search != null && !search.isEmpty()) {
                // 검색어가 있는 경우 검색 수행
                Track[] tracks = spotifyService.searchTracks(search);
                req.setAttribute("tracks", tracks);
            } else {
                // 검색어가 없을 경우 랜덤한 추천 트랙 가져오기
                Track[] recommendedTracks = spotifyService.getRandomRecommendations();
                req.setAttribute("tracks", recommendedTracks);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "An error occurred while fetching the tracks.");
        }
        
        return "music/musicList";
    }


	@GetMapping("/resentPlay.do")
	public String resentPlay() {
		return "music/resentPlay";
	}
	

}
