package com.example.musicemotion.playlist_songs.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.musicemotion.dto.Playlist_SongsDTO;



@Service
public class Playlist_SongsService {

	@Autowired
	private  SqlSession sqlSession;
	
    public boolean addPlaylist_songs(Playlist_SongsDTO dto) {
        int result = sqlSession.insert("addPlaylist_songs", dto);
        return result > 0;
    }
    
	public int countPlaylistSongs(int playlist_id) {
		return sqlSession.selectOne("countPlaylistSongs", playlist_id);
	}
    
	public List<String> playlist_songsAll(int playlist_id) {
		return sqlSession.selectList("playlist_songsAll", playlist_id);
	}
	 
	public void deletePlaylist_songs(String song_id) {
		sqlSession.delete("deletePlaylist_songs",song_id);
	}
}
