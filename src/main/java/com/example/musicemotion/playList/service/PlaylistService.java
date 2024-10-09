package com.example.musicemotion.playList.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.musicemotion.dto.PlaylistDTO;



@Service
public class PlaylistService {

	@Autowired
	private  SqlSession sqlSession;
	
	 public void addPlaylist(PlaylistDTO dto) {
		 sqlSession.insert("addPlaylist", dto);
	 }
	 
	 public PlaylistDTO playlistAll(String user_id) {
		 return  sqlSession.selectOne("playlistAll", user_id);
	 }
	 
	 public void updatePlaylist(PlaylistDTO dto) {
		 sqlSession.update("updatePlaylist", dto);
	 }
	 
	 public void deletePlaylist(int playlist_id) {
		 sqlSession.delete("deletePlaylist",playlist_id);
	 }
}
