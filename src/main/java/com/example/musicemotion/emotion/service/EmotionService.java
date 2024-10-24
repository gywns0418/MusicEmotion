package com.example.musicemotion.emotion.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.musicemotion.dto.EmotionDTO;



@Service
public class EmotionService {

	@Autowired
	private  SqlSession sqlSession;
	
	public void addEmotion(EmotionDTO dto) {
		sqlSession.insert("addEmotion", dto);
	}
	 
	public List<EmotionDTO> emotionAll() {
		return sqlSession.selectList("emotionAll");
	}
	
	public List<EmotionDTO> emotionId(int emotion_id) {
		return sqlSession.selectList("emotionAll",emotion_id);
	}
	 
	public void updateEmotion(EmotionDTO dto) {
		sqlSession.update("updateEmotion", dto);
	}
	 
	public void deleteEmotion(int emotion_id) {
		sqlSession.delete("deleteEmotion",emotion_id);
	}
}
