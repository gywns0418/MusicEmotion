package com.example.musicemotion.playList.service;

import java.util.List;

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
	 
	 public List<PlaylistDTO> playlistAll(String user_id) {
		 return  sqlSession.selectList("playlistAll", user_id);
	 }
	 
	 public PlaylistDTO playlistId(int playlist_id) {
		 return  sqlSession.selectOne("playlistId", playlist_id);
	 }
	 
	 public void updatePlaylist(PlaylistDTO dto) {
		 sqlSession.update("updatePlaylist", dto);
	 }
	 
	 public void deletePlaylist(int playlist_id) {
		 sqlSession.delete("deletePlaylist",playlist_id);
	 }
}
