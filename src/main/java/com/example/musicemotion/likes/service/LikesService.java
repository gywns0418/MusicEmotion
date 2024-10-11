package com.example.musicemotion.likes.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.example.musicemotion.dto.LikesDTO;

@Service
public class LikesService {

	@Autowired
	private  SqlSession sqlSession;
	
	 public void addLikes(LikesDTO dto) {
		 sqlSession.insert("addLikes", dto);
	 }
	 
	 public List<LikesDTO> likesAll(String user_id) {
		 return  sqlSession.selectList("likesAll", user_id);
	 }
	 
	 public void deleteLikes(int like_id) {
		 sqlSession.delete("deleteLikes",like_id);
	 }
}
