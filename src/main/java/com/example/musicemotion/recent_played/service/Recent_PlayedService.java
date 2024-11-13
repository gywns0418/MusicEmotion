package com.example.musicemotion.recent_played.service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.musicemotion.dto.Recent_PlayedDTO;
import com.example.musicemotion.spotify.service.SpotifyService;

import se.michaelthelin.spotify.model_objects.specification.Track;



@Service
public class Recent_PlayedService {

	@Autowired
	private  SqlSession sqlSession;
	
	@Autowired
	SpotifyService spotifyService;
	
	public void addRecent_Played(Recent_PlayedDTO dto) {
		sqlSession.insert("addRecent_Played", dto);
	}
	 
	public List<String> recent_playedAll(String user_id) {
		return sqlSession.selectList("recent_playedAll", user_id);
	}
	
    public List<Map<String, Object>> getTopPlayedSongs(String user_id) {
        List<Map<String, Object>> topSongs = sqlSession.selectList("getTopPlayedSongs", user_id);
        
        
        return topSongs.stream().map(song -> {
            String songId = (String) song.get("SONG_ID");
			try {
				Track track = spotifyService.getTrack(songId);
	            song.put("trackname", track.getName()); 
	            song.remove("SONG_ID"); 
			} catch (Exception e) {
				e.printStackTrace();
				song.put("trackname", "Unknown Track");
			} 
            return song;
        }).collect(Collectors.toList());
    }
	
	public int getMonthlyPlayCount(String user_id) {
		return sqlSession.selectOne("getMonthlyPlayCount",user_id);
	}
	
	public String getMostPlayedSongId(String user_id) {
		return sqlSession.selectOne("getMostPlayedSongId",user_id);
	}
}

