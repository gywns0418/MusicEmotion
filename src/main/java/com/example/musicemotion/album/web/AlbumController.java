package com.example.musicemotion.album.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.musicemotion.album.service.AlbumService;
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
        
        List<Album> albums = spotifyService.getAlbumsDetails(followedAlbums);

        List<Map<String, Object>> albumDetails = new ArrayList<>();
        for (Album album : albums) {
            Map<String, Object> details = new HashMap<>();
            details.put("id", album.getId());
            details.put("name", album.getName());
            details.put("releaseDate", album.getReleaseDate());
            details.put("totalTracks", album.getTracks().getTotal());  // 총 트랙 수만 전달
            details.put("popularity", album.getPopularity());

            // 첫 번째 이미지와 첫 번째 아티스트만 사용
            if (album.getImages() != null && album.getImages().length > 0) {
                details.put("imageUrl", album.getImages()[0].getUrl());
            } else {
                details.put("imageUrl", "/images/placeholder.jpg"); // 기본 이미지 경로
            }
            
            if (album.getArtists() != null && album.getArtists().length > 0) {
                details.put("artistName", album.getArtists()[0].getName());
            } else {
                details.put("artistName", "Unknown Artist"); // 기본 아티스트 이름
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
        albumData.put("title", album.getName()); // 앨범 제목
        albumData.put("artist", album.getArtists().length > 0 ? album.getArtists()[0].getName() : "Unknown Artist"); // 아티스트 이름
        albumData.put("coverUrl", album.getImages().length > 0 ? album.getImages()[0].getUrl() : "/images/placeholder.jpg"); // 앨범 커버 이미지
        albumData.put("releaseDate", album.getReleaseDate()); // 발매일
        albumData.put("genre", album.getGenres().length > 0 ? album.getGenres()[0] : "Unknown Genre"); // 장르
        albumData.put("trackCount", album.getTracks().getTotal()); // 총 트랙 수
        albumData.put("likes", 0); // 좋아요 수 (API에서 직접 제공되지 않으므로 기본값 설정)
        
        // 앨범의 총 재생 시간 계산
        int totalDuration = 0;
        for (TrackSimplified track : album.getTracks().getItems()) {
            totalDuration += track.getDurationMs();
        }
        albumData.put("duration", formatDuration(totalDuration)); // 형식화된 재생 시간

        // 트랙 목록 정보
        List<Map<String, Object>> tracks = new ArrayList<>();
        for (TrackSimplified track : album.getTracks().getItems()) {
            Map<String, Object> trackData = new HashMap<>();
            trackData.put("name", track.getName());
            trackData.put("duration", formatDuration(track.getDurationMs()));
            tracks.add(trackData);
        }
        albumData.put("tracks", tracks); // 트랙 목록

        req.setAttribute("album", albumData);

        return "album/albumDetail";
    }

    // 밀리초 단위의 재생 시간을 "분:초" 형식으로 변환하는 메서드
    private String formatDuration(int durationMs) {
        int minutes = (durationMs / 1000) / 60;
        int seconds = (durationMs / 1000) % 60;
        return String.format("%d:%02d", minutes, seconds);
    }



}
