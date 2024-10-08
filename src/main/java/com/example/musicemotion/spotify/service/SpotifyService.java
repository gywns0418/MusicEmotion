package com.example.musicemotion.spotify.service;

import org.apache.hc.core5.http.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.Album;
import se.michaelthelin.spotify.model_objects.specification.Artist;
import se.michaelthelin.spotify.model_objects.specification.AudioFeatures;
import se.michaelthelin.spotify.model_objects.specification.Recommendations;
import se.michaelthelin.spotify.model_objects.specification.Track;
import se.michaelthelin.spotify.requests.authorization.client_credentials.ClientCredentialsRequest;
import se.michaelthelin.spotify.requests.data.albums.GetAlbumRequest;
import se.michaelthelin.spotify.requests.data.artists.GetArtistRequest;
import se.michaelthelin.spotify.requests.data.browse.GetRecommendationsRequest;
import se.michaelthelin.spotify.requests.data.tracks.GetAudioFeaturesForTrackRequest;
import se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest;

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
            .max_energy(0.7f) // Energy
            .min_energy(0.4f)
            .max_loudness(-3f) // Loudness
            .min_loudness(-10f)
            .min_tempo(80f) // Tempo
            .max_tempo(120f)
            .max_valence(0.9f) // Valence
            .min_valence(0.6f)
            .seed_tracks("2X45nVBeYzmDlrXji9Av0Q")
            .build();

        return recommendationsRequest.execute();
    }
    
    public Track getTrack(String trackId) throws Exception {
    	spotifyApi.setAccessToken(getAccessToken());
    	
        GetTrackRequest getTrackRequest = spotifyApi.getTrack(trackId).build();
        return getTrackRequest.execute();
    }
    

    // 앨범 정보 가져오기
    public Album getAlbumDetail(String albumId) throws Exception {
    	spotifyApi.setAccessToken(getAccessToken());
    	
        GetAlbumRequest getAlbumRequest = spotifyApi.getAlbum(albumId).build();
        return getAlbumRequest.execute();
    }

    // 아티스트 정보 가져오기
    public Artist getArtistDetail(String artistId) throws Exception {
    	spotifyApi.setAccessToken(getAccessToken());
    	
        GetArtistRequest getArtistRequest = spotifyApi.getArtist(artistId).build();
        return getArtistRequest.execute();
    }
}
