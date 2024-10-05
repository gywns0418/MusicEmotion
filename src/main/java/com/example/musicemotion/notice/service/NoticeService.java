package com.example.musicemotion.notice.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.musicemotion.dto.NoticeDTO;



@Service
public class NoticeService {
	@Autowired
	private  SqlSession sqlSession;
	
	 public void noticeWrite(NoticeDTO dto) {
		 sqlSession.insert("noticeWrite", dto);
	 }
	 
	 public List<NoticeDTO> noticeAll() {
		return sqlSession.selectList("noticeAll");
	}
	 
	 public NoticeDTO getNoticeId(int notice_id) {
		 return sqlSession.selectOne("getNoticeId",notice_id);
	 }
	 
	 public List<NoticeDTO> searchNoticeList(String searchType, String search) {
	        Map<String, Object> params = new HashMap<>();
	        params.put("searchType", searchType);
	        params.put("search", search);
	        return sqlSession.selectList("searchNoticeList", params);
	 }
	 
	 public void noticeUpdate(NoticeDTO dto) {
		 sqlSession.update("noticeUpdate",dto);
	 }
	 
	 public void noticeDelete(int notice_id) {
		 sqlSession.delete("noticeDelete",notice_id);
	 }
}
