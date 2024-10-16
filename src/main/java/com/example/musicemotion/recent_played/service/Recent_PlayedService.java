package com.example.musicemotion.recent_played.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.musicemotion.dto.Recent_PlayedDTO;



@Service
public class Recent_PlayedService {

	@Autowired
	private  SqlSession sqlSession;
	
	public void addPlaylist(Recent_PlayedDTO dto) {
		sqlSession.insert("addPlaylist", dto);
	}
	 
	public List<Recent_PlayedDTO> recent_playedAll(String user_id) {
		return sqlSession.selectList("recent_playedAll", user_id);
	}
	
}

