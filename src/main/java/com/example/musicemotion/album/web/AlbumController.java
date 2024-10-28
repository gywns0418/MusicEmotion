package com.example.musicemotion.album.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.musicemotion.album.service.AlbumService;
import com.example.musicemotion.dto.AlbumDTO;
import com.example.musicemotion.dto.ArtistDTO;
import com.example.musicemotion.spotify.service.SpotifyService;

import jakarta.servlet.http.HttpServletRequest;
import se.michaelthelin.spotify.model_objects.specification.Album;
import se.michaelthelin.spotify.model_objects.specification.Artist;
import se.michaelthelin.spotify.model_objects.specification.TrackSimplified;

@Controller
@RequestMapping("/album")
public class AlbumController {

    @Autowired
    AlbumService albumService;
    
    @Autowired
    SpotifyService spotifyService;
    
    @GetMapping("/album.do")
    public String album(HttpServletRequest req) throws Exception {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();

        // 팔로우한 앨범 목록 조회
        List<String> followedAlbums = albumService.albumIdAll(username);

        // 유효한 형식의 앨범 ID만 필터링
        List<String> validAlbumIds = followedAlbums.stream()
                .filter(id -> id != null && id.matches("^[A-Za-z0-9]{22}$"))
                .collect(Collectors.toList());

        // 필터링된 ID 목록으로 Spotify API 호출
        List<Album> albums = spotifyService.getAlbumsDetails(validAlbumIds);

        List<Map<String, Object>> albumDetails = new ArrayList<>();
        for (Album album : albums) {
            if (album == null) {
                continue;  // album이 null인 경우 건너뜁니다.
            }
            Map<String, Object> details = new HashMap<>();
            details.put("id", album.getId());
            details.put("name", album.getName());
            details.put("releaseDate", album.getReleaseDate());
            details.put("totalTracks", album.getTracks().getTotal());
            details.put("popularity", album.getPopularity());

            // 첫 번째 이미지와 첫 번째 아티스트만 사용
            if (album.getImages() != null && album.getImages().length > 0) {
                details.put("imageUrl", album.getImages()[0].getUrl());
            } else {
                details.put("imageUrl", "/images/placeholder.jpg");
            }
            
            if (album.getArtists() != null && album.getArtists().length > 0) {
                details.put("artistName", album.getArtists()[0].getName());
            } else {
                details.put("artistName", "Unknown Artist");
            }
            
            albumDetails.add(details);
        }

        req.setAttribute("albumDetails", albumDetails);
        
        return "album/album";
    }


	
    @GetMapping("/albumDetail.do")
    public String albumDetail(HttpServletRequest req) throws Exception {
        String albumId = req.getParameter("album_id");

        // Spotify API에서 단일 앨범 세부 정보 가져오기
        Album album = spotifyService.getAlbumDetail(albumId);

        Map<String, Object> albumData = new HashMap<>();
        albumData.put("title", album.getName());
        albumData.put("artist", album.getArtists().length > 0 ? album.getArtists()[0].getName() : "Unknown Artist");
        albumData.put("coverUrl", album.getImages().length > 0 ? album.getImages()[0].getUrl() : "/images/placeholder.jpg");
        albumData.put("releaseDate", album.getReleaseDate());
        albumData.put("genre", album.getGenres().length > 0 ? album.getGenres()[0] : "Unknown Genre");
        albumData.put("trackCount", album.getTracks().getTotal());
        albumData.put("likes", 0);

        int totalDuration = 0;
        List<Map<String, Object>> tracks = new ArrayList<>();

        for (TrackSimplified track : album.getTracks().getItems()) {
            Map<String, Object> trackData = new HashMap<>();
            trackData.put("name", track.getName());
            trackData.put("duration", formatDuration(track.getDurationMs()));

            // 트랙의 세부 정보를 가져와 이미지 추가 (예시: spotifyService.getTrackDetail)
            var trackDetail = spotifyService.getTrack(track.getId()); // 새로운 메서드 필요
            if (trackDetail.getAlbum().getImages() != null && trackDetail.getAlbum().getImages().length > 0) {
                trackData.put("imageUrl", trackDetail.getAlbum().getImages()[0].getUrl());
            } else {
                trackData.put("imageUrl", "/images/placeholder.jpg");
            }

            totalDuration += track.getDurationMs();
            tracks.add(trackData);
        }

        albumData.put("duration", formatDuration(totalDuration));
        albumData.put("tracks", tracks);

        req.setAttribute("album", albumData);

        return "album/albumDetail";
    }

    // 밀리초 단위의 재생 시간을 "분:초" 형식으로 변환하는 메서드
    private String formatDuration(int durationMs) {
        int minutes = (durationMs / 1000) / 60;
        int seconds = (durationMs / 1000) % 60;
        return String.format("%d:%02d", minutes, seconds);
    }

	@PostMapping("/follow")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> followArtist(@RequestBody Map<String, Object> payload) {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String username = authentication.getName();

	    String albumId = (String) payload.get("album_id");
	    boolean following = (boolean) payload.get("following");

	    AlbumDTO dto = new AlbumDTO();
	    dto.setUser_id(username);
	    dto.setAlbum_id(albumId);

	    boolean success;
	    try {
	        success = following ? albumService.addAlbum(dto) : albumService.deleteAlbum(dto);
	    } catch (Exception e) {
	        e.printStackTrace();
	        success = false;
	    }

	    Map<String, Object> response = new HashMap<>();
	    response.put("success", success);
	    return ResponseEntity.ok(response);
	}


}
