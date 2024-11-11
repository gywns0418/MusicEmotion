package com.example.musicemotion.musixmatch.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class MusixmatchService {

    private static final String API_KEY = "7e5c8e1f0b15883f7a983ae0218f9b02"; // API Key 설정

    public String getLyricsByTrackName(String trackName, String artistName) throws Exception {
        // 곡 제목과 아티스트 이름을 URL 인코딩하여 요청 URL을 생성
        String urlString = "https://api.musixmatch.com/ws/1.1/matcher.lyrics.get?q_track=" 
                + URLEncoder.encode(trackName, "UTF-8") 
                + "&q_artist=" + URLEncoder.encode(artistName, "UTF-8")
                + "&apikey=" + API_KEY;

        URL url = new URL(urlString);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("GET");

        // 응답 코드 확인
        int responseCode = connection.getResponseCode();
        System.out.println("Response Code: " + responseCode);

        BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
        String inputLine;
        StringBuffer content = new StringBuffer();

        while ((inputLine = in.readLine()) != null) {
            content.append(inputLine);
        }
        in.close();

        // 응답 내용 출력
        System.out.println("Response Content: " + content.toString());

        // JSON 파싱하여 가사 추출
        ObjectMapper mapper = new ObjectMapper();
        JsonNode rootNode = mapper.readTree(content.toString());
        JsonNode lyricsNode = rootNode.path("message").path("body").path("lyrics").path("lyrics_body");

        if (lyricsNode.isMissingNode() || lyricsNode.asText().isEmpty()) {
            return "제공되지 않는 가사 정보입니다.";
        } else {
            return lyricsNode.asText();
        }
    }
    

    
}
