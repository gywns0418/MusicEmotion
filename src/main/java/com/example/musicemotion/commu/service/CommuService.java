package com.example.musicemotion.commu.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.musicemotion.dto.CommuDTO;



@Service
public class CommuService {
	
	@Autowired
	private  SqlSession sqlSession;
	
	 public void commuWrite(CommuDTO dto) {
		 sqlSession.insert("commuWrite", dto);
	 }
	 
	 public List<CommuDTO> commuAll() {
		return sqlSession.selectList("commuAll");
	}
	 
	 public CommuDTO getCommuId(int post_id) {
		 return sqlSession.selectOne("getCommuId",post_id);
	 }
	 
	 public List<CommuDTO> searchCommuList(String searchType, String search) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("searchType", searchType);
	        params.put("search", search);
	        return sqlSession.selectList("searchCommuList", params);
	 }
	 
	 public void commuUpdate(CommuDTO dto) {
		 sqlSession.update("commuUpdate",dto);
	 }
	 
	 public void commuDelete(int post_id) {
		 sqlSession.delete("commuDelete",post_id);
	 }
}