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
import com.example.musicemotion.emotion.service.EmotionService;
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
	
	@PostMapping("/recommendMusic.do")
	@ResponseBody
	public String recommendMusic(@RequestParam("emotion_id") int emotionId, @RequestParam("genre") String genre) {
	    try {
	        // 감정 값에 따른 추천 트랙 로직 수행
	        EmotionDTO dto = emotionService.emotionId(emotionId);

	        float minDanceability = dto.getDanceability_min();
	        float maxDanceability = dto.getDanceability_max();
	        float minEnergy = dto.getEnergy_min();
	        float maxEnergy = dto.getEnergy_max();
	        float minLoudness = dto.getLoudness_min();
	        float maxLoudness = dto.getLoudness_max();
	        float minTempo = dto.getTempo_min();
	        float maxTempo = dto.getTempo_max();
	        float minValence = dto.getValance_min();
	        float maxValence = dto.getValance_max();

	        // SpotifyService를 통해 추천 트랙 가져오기
	        List<TrackSimplified> recommendedTracks = spotifyService.getRecommendedTracks(
	            minDanceability, maxDanceability, minEnergy, maxEnergy, minLoudness,
	            maxLoudness, minTempo, maxTempo, minValence, maxValence, genre
	        );

	        StringBuilder responseContent = new StringBuilder("<h2>추천 음악</h2><div class='playlist-grid'>");

	        for (TrackSimplified trackSimplified : recommendedTracks) {
	            Track track = spotifyService.getTrack(trackSimplified.getId()); // Track 정보 추가 조회

	            String trackTitle = track.getName();
	            String trackImageUrl = track.getAlbum().getImages()[0].getUrl();

	            // 클라이언트에서 contextPath를 사용해 URL을 생성하도록 설정
	            responseContent.append("<a href='").append("/spotify/musicDetail.do?song_id=").append(track.getId())
	               .append("'><div class='playlist-card'>")  // target='_blank' 제거
	               .append("<img src='").append(trackImageUrl).append("' alt='앨범 커버'>")
	               .append("<div class='playlist-title'>").append(trackTitle).append("</div>")
	               .append("<div class='playlist-description'>").append(track.getArtists()[0].getName()).append("</div>")
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
