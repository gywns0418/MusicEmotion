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
            .limit(5) // 추천받을 트랙 수
            .max_danceability(0.8f) // Danceability
            .min_danceability(0.5f)
            .max_energy(1.0f) // Energy
            .min_energy(0.7f)
            .max_loudness(0f) // Loudness
            .min_loudness(-10f)
            .min_tempo(120f) // Tempo
            .max_tempo(150f)
            .max_valence(0.3f) // Valence
            .min_valence(0.0f)
            .seed_genres("k-pop")
            .build();

        return recommendationsRequest.execute();
    }
}
