package com.example.musicemotion.playlist_songs.web;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.musicemotion.dto.Playlist_SongsDTO;
import com.example.musicemotion.playlist_songs.service.Playlist_SongsService;



@Controller
@RequestMapping("/playlistSong")
public class Playlist_SongsController {
	
    @Autowired
    Playlist_SongsService playlist_SongsService;

    @PostMapping("/addTrack")
    @ResponseBody
    public Map<String, Object> addTrackToPlaylist(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();
        try {
            int playlistId = Integer.parseInt(request.get("playlist_id").toString());
            String trackId = request.get("track_id").toString();

            Playlist_SongsDTO psDto = new Playlist_SongsDTO();
            psDto.setPlaylist_id(playlistId);
            psDto.setSong_id(trackId);
            
            boolean isAdded = playlist_SongsService.addPlaylist_songs(psDto);

            response.put("success", isAdded);
        } catch (Exception e) {
            e.printStackTrace();
            response.put("success", false);
        }
        return response;
    }
}
