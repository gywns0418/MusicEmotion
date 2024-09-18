package com.example.musicemotion.spotify.web;

import org.apache.hc.core5.http.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.example.musicemotion.spotify.service.SpotifyService;

import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.AudioFeatures;
import se.michaelthelin.spotify.model_objects.specification.Recommendations;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

@RestController
@RequestMapping("/api/spotify")
public class SpotifyController {

    private final SpotifyService spotifyService;

    @Autowired
    public SpotifyController(SpotifyService spotifyService) {
        this.spotifyService = spotifyService;
    }

    @GetMapping("/audio-features/{trackId}")
    public AudioFeatures getAudioFeatures(@PathVariable String trackId) 
    		throws IOException, SpotifyWebApiException, ExecutionException, InterruptedException, ParseException {
        return spotifyService.getAudioFeaturesForTrack(trackId);
    }
    
    @GetMapping("/recommended-tracks")
    public Recommendations getRecommendedTracks() 
    		throws IOException, SpotifyWebApiException, ExecutionException, InterruptedException, ParseException {
        return spotifyService.getRecommendedTracks();
    }
}
