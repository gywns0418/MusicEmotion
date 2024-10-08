package com.example.musicemotion.album.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AlbumService {

	@Autowired
	private  SqlSession sqlSession;
}
