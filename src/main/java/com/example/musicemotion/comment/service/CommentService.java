package com.example.musicemotion.comment.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.musicemotion.dto.CommentsDTO;


@Service
public class CommentService {

	@Autowired
	private  SqlSession sqlSession;
	
	 public void addComments(CommentsDTO dto) {
		 sqlSession.insert("addComments", dto);
	 }
	 
	 public CommentsDTO commentsAll(String post_id) {
		 return  sqlSession.selectOne("commentsAll", post_id);
	 }
	 
	 public void updateComments(CommentsDTO dto) {
		 sqlSession.update("updateComments", dto);
	 }
	 
	 public void deleteComments(int comment_id) {
		 sqlSession.delete("deleteComments",comment_id);
	 }
}
