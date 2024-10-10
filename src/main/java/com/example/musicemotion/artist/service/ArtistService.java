package com.example.musicemotion.artist.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.musicemotion.dto.ArtistDTO;


@Service
public class ArtistService {

	@Autowired
	private  SqlSession sqlSession;
	
	 public void addArtist(ArtistDTO dto) {
		 sqlSession.insert("addArtist", dto);
	 }
	 
	 public ArtistDTO artistAll(String user_id) {
		 return  sqlSession.selectOne("artistAll", user_id);
	 }
	 
	 public void updateArtist(ArtistDTO dto) {
		 sqlSession.update("updateArtist", dto);
	 }
	 
	 public void deleteAlbum(String artist_id) {
		 sqlSession.delete("deleteAlbum",artist_id);
	 }
}
