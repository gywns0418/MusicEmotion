package com.example.musicemotion.emotion.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.musicemotion.dto.EmotionDTO;
import com.example.musicemotion.dto.RecomendDTO;
import com.example.musicemotion.emotion.service.EmotionService;
import com.example.musicemotion.recomend.service.RecomendService;
import com.example.musicemotion.spotify.service.SpotifyService;

import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.model_objects.specification.TrackSimplified;

@Controller
@RequestMapping("/emotion")
public class EmotionController {
	
	@Autowired
	SpotifyService spotifyService;
	
	@Autowired
	EmotionService emotionService;
	
	@Autowired
	RecomendService recomendService;
	
	@PostMapping("/recommendMusic.do")
	@ResponseBody
	public String recommendMusic(@RequestParam("emotion_id") int emotionId, @RequestParam("genre") String genre) {
	    try {
	        // 감정 ID를 기반으로 emotion 값을 가져오기
	        EmotionDTO dto = emotionService.emotionId(emotionId);
	        String emotion = dto.getEmotion_name(); // 감정 이름 가져오기 (EmotionDTO에 적합한 필드 추가 필요)

	        RecomendDTO rdto = new RecomendDTO();
	        rdto.setEmotion(emotion);
	        rdto.setGenres(genre);
	        
	        // Recomend 테이블에서 해당 감정과 장르에 맞는 데이터를 가져오기
	        List<RecomendDTO> recommendedTracks = recomendService.selectSong(rdto);

	        // HTML로 추천 결과 생성
	        StringBuilder responseContent = new StringBuilder("<h2>추천 음악</h2><div class='playlist-grid'>");

	        for (RecomendDTO track : recommendedTracks) {
	        	Track song = spotifyService.getTrack(track.getSong_id());
	            String trackTitle = song.getName();
	            String trackImageUrl = song.getAlbum().getImages()[0].getUrl();

	            // 클라이언트에서 contextPath를 사용해 URL을 생성하도록 설정
	            responseContent.append("<a href='").append("/spotify/musicDetail.do?song_id=").append(track.getSong_id())
	                .append("'><div class='playlist-card'>")  // target='_blank' 제거
	                .append("<img src='").append(trackImageUrl).append("' alt='앨범 커버'>")
	                .append("<div class='playlist-title'>").append(trackTitle).append("</div>")
	                .append("<div class='playlist-description'>").append(genre).append("</div>")
	                .append("</div></a>");
	        }

	        responseContent.append("</div>");
	        return responseContent.toString();

	    } catch (Exception e) {
	        e.printStackTrace();
	        return "<p>추천을 가져오는 중 오류가 발생했습니다.</p>";
	    }
	}



}
