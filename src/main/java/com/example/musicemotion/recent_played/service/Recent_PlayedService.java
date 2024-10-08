package com.example.musicemotion.recent_played.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Recent_PlayedService {

	@Autowired
	private  SqlSession sqlSession;
}

