package com.example.musicemotion.playList.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PlaylistService {

	@Autowired
	private  SqlSession sqlSession;
}
