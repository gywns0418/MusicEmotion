package com.example.musicemotion.likes.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LikesService {

	@Autowired
	private  SqlSession sqlSession;
}
