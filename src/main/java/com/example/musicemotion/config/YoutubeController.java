package com.example.musicemotion.config;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

@Controller
public class YoutubeController {

    private static final String API_KEY = "AIzaSyBZ47cGru--ikRevyqu8iBL3gRZR1ddP9E";  // 실제 API 키로 대체하세요
    private static final String YOUTUBE_API_URL = "https://www.googleapis.com/youtube/v3/search";

    @GetMapping("/youtube/search")
    public ResponseEntity<String> searchYouTube(@RequestParam String query) {
        RestTemplate restTemplate = new RestTemplate();
        String url = YOUTUBE_API_URL + "?part=snippet&q=" + query + "&key=" + API_KEY + "&maxResults=5&type=video";
        return restTemplate.getForEntity(url, String.class);
    }
}
