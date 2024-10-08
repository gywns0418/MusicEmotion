package com.example.musicemotion.playlist_songs.service;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class Playlist_SongsService {

	@Autowired
	private  SqlSession sqlSession;
}
