package com.example.musicemotion.spotify.service;

import org.apache.hc.core5.http.ParseException;
import org.springframework.stereotype.Service;

import com.neovisionaries.i18n.CountryCode;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.specification.*;
import se.michaelthelin.spotify.requests.authorization.client_credentials.ClientCredentialsRequest;
import se.michaelthelin.spotify.requests.data.albums.GetAlbumRequest;
import se.michaelthelin.spotify.requests.data.artists.GetArtistRequest;
import se.michaelthelin.spotify.requests.data.browse.GetListOfFeaturedPlaylistsRequest;
import se.michaelthelin.spotify.requests.data.browse.GetRecommendationsRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetPlaylistRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetPlaylistsItemsRequest;
import se.michaelthelin.spotify.requests.data.search.simplified.SearchTracksRequest;
import se.michaelthelin.spotify.requests.data.tracks.GetAudioFeaturesForTrackRequest;
import se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.Arrays;
import java.util.stream.Collectors;

@Service
public class SpotifyService {

    private final SpotifyApi spotifyApi;
    private String accessToken;
    private Instant tokenExpirationTime;

    public SpotifyService(SpotifyApi spotifyApi) {
        this.spotifyApi = spotifyApi;
        refreshToken();
    }

    private void refreshToken() {
        try {
            ClientCredentialsRequest clientCredentialsRequest = spotifyApi.clientCredentials().build();
            this.accessToken = clientCredentialsRequest.execute().getAccessToken();
            this.tokenExpirationTime = Instant.now().plusSeconds(3600); // Assuming token validity is 1 hour
            spotifyApi.setAccessToken(accessToken);
        } catch (IOException | SpotifyWebApiException | ParseException e) {
            System.err.println("Failed to authenticate with Spotify API: " + e.getMessage());
        }
    }

    private void ensureAccessToken() {
        if (accessToken == null || Instant.now().isAfter(tokenExpirationTime)) {
            refreshToken();
        }
    }

    //검색으로 노래
    public Track[] searchTracks(String search) throws Exception {
        ensureAccessToken();

        // 검색어 유효성 검사
        if (search == null || search.trim().isEmpty()) {
            throw new IllegalArgumentException("Search term cannot be null or empty.");
        }

        SearchTracksRequest searchTracksRequest = spotifyApi.searchTracks(search)
        		.limit(50)
        		.market(CountryCode.KR)
        		.build();
        return searchTracksRequest.execute().getItems();
    }
    
    //검색결과 없을때 랜덤 노래
    public Track[] getRandomRecommendations() throws Exception {
        ensureAccessToken();

        try {
            GetRecommendationsRequest recommendationsRequest = spotifyApi.getRecommendations()
                    .limit(50) 
                    .seed_genres("k-pop") 
                    .build();

            Recommendations recommendations = recommendationsRequest.execute();
            
            // TrackSimplified[]이 아닌 Track[]로 변환
            String[] trackIds = Arrays.stream(recommendations.getTracks())
                                      .map(TrackSimplified::getId)
                                      .toArray(String[]::new);

            return spotifyApi.getSeveralTracks(trackIds).build().execute();
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.err.println("Error fetching random recommendations: " + e.getMessage());
            throw e;
        }
    }

    public String getTrackArtists(Track track) {
        return Arrays.stream(track.getArtists())
                     .map(artist -> artist.getName())
                     .collect(Collectors.joining(", "));
    }
    
    public Track getTrack(String trackId) throws Exception {
        ensureAccessToken();

        try {
            GetTrackRequest getTrackRequest = spotifyApi.getTrack(trackId).build();
            return getTrackRequest.execute();
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.err.println("Error getting track: " + e.getMessage());
            throw e;
        }
    }

    public AudioFeatures getAudioFeaturesForTrack(String trackId) throws Exception {
        ensureAccessToken();

        try {
            GetAudioFeaturesForTrackRequest request = spotifyApi.getAudioFeaturesForTrack(trackId).build();
            return request.execute();
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.err.println("Error getting audio features for track: " + e.getMessage());
            throw e;
        }
    }

    public Recommendations getRecommendedTracks() throws Exception {
        ensureAccessToken();

        try {
            GetRecommendationsRequest request = spotifyApi.getRecommendations()
                    .limit(5)
                    .max_danceability(0.8f)
                    .min_danceability(0.5f)
                    .max_energy(0.7f)
                    .min_energy(0.4f)
                    .max_loudness(-3f)
                    .min_loudness(-10f)
                    .min_tempo(80f)
                    .max_tempo(120f)
                    .max_valence(0.9f)
                    .min_valence(0.6f)
                    .seed_tracks("2X45nVBeYzmDlrXji9Av0Q")
                    .build();

            return request.execute();
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.err.println("Error getting recommended tracks: " + e.getMessage());
            throw e;
        }
    }

    public Album getAlbumDetail(String albumId) throws Exception {
        ensureAccessToken();

        try {
            GetAlbumRequest request = spotifyApi.getAlbum(albumId).build();
            return request.execute();
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.err.println("Error getting album detail: " + e.getMessage());
            throw e;
        }
    }

    public Artist getArtistDetail(String artistId) throws Exception {
        ensureAccessToken();

        try {
            GetArtistRequest request = spotifyApi.getArtist(artistId).build();
            return request.execute();
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.err.println("Error getting artist detail: " + e.getMessage());
            throw e;
        }
    }

    public Playlist getPlaylist(String playlistId) throws Exception {
        ensureAccessToken();

        try {
            GetPlaylistRequest request = spotifyApi.getPlaylist(playlistId).build();
            return request.execute();
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.err.println("Error getting playlist: " + e.getMessage());
            throw e;
        }
    }

    public Recommendations getRecommendations(String seedGenre, int limit) throws Exception {
        ensureAccessToken();

        try {
            GetRecommendationsRequest request = spotifyApi.getRecommendations()
                    .limit(limit)
                    .seed_genres(seedGenre)
                    .build();

            return request.execute();
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.err.println("Error getting recommendations: " + e.getMessage());
            throw e;
        }
    }

    public PlaylistSimplified[] getFeaturedPlaylists(int limit) throws Exception {
        ensureAccessToken();

        try {
            GetListOfFeaturedPlaylistsRequest request = spotifyApi.getListOfFeaturedPlaylists()
                    .limit(limit)
                    .build();

            return request.execute().getPlaylists().getItems();
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.err.println("Error getting featured playlists: " + e.getMessage());
            throw e;
        }
    }

    public PlaylistTrack[] getPlaylistTracks(String playlistId, int limit) throws Exception {
        ensureAccessToken();

        try {
            GetPlaylistsItemsRequest request = spotifyApi.getPlaylistsItems(playlistId)
                    .limit(limit)
                    .build();

            return request.execute().getItems();
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.err.println("Error getting playlist tracks: " + e.getMessage());
            throw e;
        }
    }
}
