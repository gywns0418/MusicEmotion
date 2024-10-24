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
		 int count = sqlSession.selectOne("isLikeExists",dto);
		 
		 if (count == 0) {
			 sqlSession.insert("addLikes", dto);
	     } else {
	    	 System.out.println("이미 좋아요가 존재합니다.");
	     }
	 }
	 
	 public List<String> likesAll(String user_id) {
		 return  sqlSession.selectList("likesAll", user_id);
	 }
	 
	 public void deleteLikes(LikesDTO dto) {
		 sqlSession.delete("deleteLikes",dto);
	 }
}
