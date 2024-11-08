package com.example.musicemotion.playList.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.musicemotion.config.FileUploadUtil;
import com.example.musicemotion.dto.PlaylistDTO;
import com.example.musicemotion.dto.Playlist_SongsDTO;
import com.example.musicemotion.playList.service.PlaylistService;
import com.example.musicemotion.playlist_songs.service.Playlist_SongsService;
import com.example.musicemotion.spotify.service.SpotifyService;

import jakarta.servlet.http.HttpServletRequest;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.Playlist;
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
	
	@Autowired
	Playlist_SongsService playlist_SongsService;
	
	@GetMapping("/playListMain.do")
	public String playListMain(HttpServletRequest req,String playlist_id) throws Exception {
        int trackLimit = 20; // 각 플레이리스트에서 가져올 트랙 수 제한

        try {
        	Playlist playlist = spotifyService.getPlaylistById(playlist_id);
        	
            // 플레이리스트 제목과 이미지를 가져오기
            String playlistName = playlist.getName();  // 플레이리스트 제목
            String playlistDescription = playlist.getDescription();
            String playlistImageUrl = playlist.getImages()[0].getUrl();  // 첫 번째 이미지 URL
            
            req.setAttribute("playlistName", playlistName);
            req.setAttribute("playlistDescription", playlistDescription);
            req.setAttribute("playlistImage", playlistImageUrl);
        	
            // Spotify API를 사용하여 플레이리스트의 트랙을 가져오기
            PlaylistTrack[] tracks = spotifyService.getPlaylistTracks(playlist_id, trackLimit);
            req.setAttribute("tracks", tracks);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
		return "playlist/playListMain";
	}
	
    @GetMapping("/myPlayList.do")
    public String playListAdd(HttpServletRequest req, @RequestParam("playlist_id") int playlistId) throws Exception {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();

        // 해당 사용자에 대한 모든 플레이리스트를 가져옴
        List<PlaylistDTO> listAll = playlistService.playlistAll(username);

        // 선택한 playlist_id에 해당하는 곡 목록을 가져옴
        List<Playlist_SongsDTO> songsAll = playlist_SongsService.playlist_songsAll(playlistId);
        
        req.setAttribute("listAll", listAll);
        req.setAttribute("songsAll", songsAll);

        return "playlist/myPlayList";
    }
	
    @PostMapping("/addPlaylistAjax")
    public ResponseEntity<PlaylistDTO> addPlaylistAjax(
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam(value = "image", required = false) MultipartFile image) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();

        PlaylistDTO dto = new PlaylistDTO();
        dto.setTitle(title);
        dto.setDescription(description);
        dto.setUser_id(username);

        try {
            if (image != null && !image.isEmpty()) {
                String imagePath = FileUploadUtil.uploadImage(image); // 파일 경로만 가져옴
                dto.setImage(imagePath); // 경로를 DTO에 설정
            }
            
            playlistService.addPlaylist(dto); // 데이터베이스에 DTO 저장
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(500).build(); // 예외 발생 시 오류 응답
        }

        return ResponseEntity.ok(dto); // 성공 시 DTO 반환
    }

}
