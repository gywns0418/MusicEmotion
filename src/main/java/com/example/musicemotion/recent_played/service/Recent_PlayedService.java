package com.example.musicemotion.recent_played.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.musicemotion.dto.Recent_PlayedDTO;



@Service
public class Recent_PlayedService {

	@Autowired
	private  SqlSession sqlSession;
	
	public void addRecent_Played(Recent_PlayedDTO dto) {
		sqlSession.insert("addRecent_Played", dto);
	}
	 
	public List<String> recent_playedAll(String user_id) {
		return sqlSession.selectList("recent_playedAll", user_id);
	}
	
	public List<Map<String, Object>> getTopPlayedSongs(String user_id){
		return sqlSession.selectList("getTopPlayedSongs",user_id);
	}
	
	public int getMonthlyPlayCount(String user_id) {
		return sqlSession.selectOne("getMonthlyPlayCount",user_id);
	}
}

