package com.example.musicemotion.album.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.musicemotion.dto.AlbumDTO;



@Service
public class AlbumService {

	@Autowired
	private  SqlSession sqlSession;
	
	public void addAlbum(AlbumDTO dto) {
		sqlSession.insert("addAlbum", dto);
	}
	 
	public List<AlbumDTO> albumAll(String user_id) {
		return sqlSession.selectList("albumAll", user_id);
	}
	 
	public void updateAlbum(AlbumDTO dto) {
		sqlSession.update("updateAlbum", dto);
	}
	 
	public void deleteAlbum(String album_id) {
		sqlSession.delete("deleteAlbum",album_id);
	}

	public List<String> albumIdAll(String user_id) {
		return sqlSession.selectList("albumIdAll", user_id);
	}
}
