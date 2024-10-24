package com.example.musicemotion.emotion.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	@PostMapping("/recommendMusic")
	public String recommendMusic(HttpServletRequest req, int emotion_id) {
	    try {
	        // 감정 값을 DB에서 가져와 처리 (예: 감정에 따른 energy, valence 등)
	    	List<EmotionDTO> dto = emotionService.emotionId(emotion_id);
	    	
	    	
	    	float minDanceability = (float) ((EmotionDTO) dto).getDanceability_min();
	    	float maxDanceability = (float) ((EmotionDTO) dto).getDanceability_max();
	    	float minEnergy = (float) ((EmotionDTO) dto).getEnergy_min();
	    	float maxEnergy = (float) ((EmotionDTO) dto).getEnergy_max();
	    	float minLoudness = (float) ((EmotionDTO) dto).getLoudness_min();
	    	float maxLoudness = (float) ((EmotionDTO) dto).getLoudness_max();
	    	float minTempo = (float) ((EmotionDTO) dto).getTempo_min();
	    	float maxTempo = (float) ((EmotionDTO) dto).getTempo_max();
	    	float minValence = (float) ((EmotionDTO) dto).getValance_min();
	    	float maxValence = (float) ((EmotionDTO) dto).getValance_max();

	        String seed_tracks = "2X45nVBeYzmDlrXji9Av0Q";

	        // SpotifyService를 통해 추천 트랙 가져오기
	        List<TrackSimplified> recommendedTracks = spotifyService.getRecommendedTracks(minDanceability, maxDanceability, minEnergy, maxEnergy, minLoudness, maxLoudness, minTempo, maxTempo, minValence, maxValence, seed_tracks);

	        // 추천 트랙을 JSP로 전달
	        req.setAttribute("recommendedTracks", recommendedTracks);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return "recommendationResult"; // 결과 페이지
	}

}
