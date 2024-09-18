package com.example.musicemotion.spotify.service;

import org.apache.hc.core5.http.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.AudioFeatures;
import se.michaelthelin.spotify.model_objects.specification.Recommendations;
import se.michaelthelin.spotify.requests.authorization.client_credentials.ClientCredentialsRequest;
import se.michaelthelin.spotify.requests.data.browse.GetRecommendationsRequest;
import se.michaelthelin.spotify.requests.data.tracks.GetAudioFeaturesForTrackRequest;

import java.io.IOException;
import java.util.concurrent.ExecutionException;

@Service
public class SpotifyService {

    private final SpotifyApi spotifyApi;

    @Autowired
    public SpotifyService(SpotifyApi spotifyApi) {
        this.spotifyApi = spotifyApi;
    }

    public String getAccessToken() 
    		throws IOException, SpotifyWebApiException, ExecutionException, InterruptedException, ParseException {
        ClientCredentialsRequest clientCredentialsRequest = spotifyApi.clientCredentials().build();
        return clientCredentialsRequest.execute().getAccessToken();
    }

    public AudioFeatures getAudioFeaturesForTrack(String trackId) throws IOException, SpotifyWebApiException, ExecutionException, InterruptedException, ParseException {
        spotifyApi.setAccessToken(getAccessToken());

        GetAudioFeaturesForTrackRequest audioFeaturesRequest = spotifyApi.getAudioFeaturesForTrack(trackId).build();
        return audioFeaturesRequest.execute();
    }
    
    public Recommendations getRecommendedTracks() 
    		throws IOException, SpotifyWebApiException, ExecutionException, InterruptedException, ParseException {
        spotifyApi.setAccessToken(getAccessToken());

        GetRecommendationsRequest recommendationsRequest = spotifyApi.getRecommendations()
            .limit(10) // 추천받을 트랙 수
            .min_danceability(0.6f) // Danceability: 0.6 ~ 1.0
            .min_energy(0.7f) // Energy: 0.7 ~ 1.0
            .max_loudness(0f) // Loudness: -10dB ~ 0dB
            .min_loudness(-10f)
            .min_tempo(100f) // Tempo: 100 ~ 140 BPM
            .max_tempo(140f)
            .min_valence(0.6f) // Valence: 0.6 ~ 1.0
            .seed_genres("k-pop")
            .build();

        return recommendationsRequest.execute();
    }
}
