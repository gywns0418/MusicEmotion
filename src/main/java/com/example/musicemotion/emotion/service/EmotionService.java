package com.example.musicemotion.emotion.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EmotionService {

	@Autowired
	private  SqlSession sqlSession;
}
