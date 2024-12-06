package com.example.musicemotion.recomend.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.musicemotion.dto.RecomendDTO;

@Service
public class RecomendService {

	@Autowired
	private  SqlSession sqlSession;
	
	public List<RecomendDTO> selectSong(RecomendDTO dto){
		return sqlSession.selectList("selectSong",dto);
	}
	
	public List<RecomendDTO> selectAllGenres(){
		return sqlSession.selectList("selectAllGenres");
	}
}

