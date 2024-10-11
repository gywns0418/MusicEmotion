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
	
	public void addPlaylist_songs(Playlist_SongsDTO dto) {
		sqlSession.insert("addPlaylist_songs", dto);
	}
	 
	public List<Playlist_SongsDTO> playlist_songsAll(int playlist_id) {
		return sqlSession.selectList("playlist_songsAll", playlist_id);
	}
	 
	public void deletePlaylist_songs(String song_id) {
		sqlSession.delete("deletePlaylist_songs",song_id);
	}
}
