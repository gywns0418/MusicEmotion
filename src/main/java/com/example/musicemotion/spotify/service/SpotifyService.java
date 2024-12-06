package com.example.musicemotion.spotify.service;

import org.apache.hc.core5.http.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.example.musicemotion.dto.EmotionDTO;
import com.example.musicemotion.playList.service.PlaylistService;
import com.neovisionaries.i18n.CountryCode;

import se.michaelthelin.spotify.SpotifyApi;
import se.michaelthelin.spotify.exceptions.SpotifyWebApiException;
import se.michaelthelin.spotify.model_objects.special.FeaturedPlaylists;
import se.michaelthelin.spotify.model_objects.specification.*;
import se.michaelthelin.spotify.requests.authorization.client_credentials.ClientCredentialsRequest;
import se.michaelthelin.spotify.requests.data.albums.GetAlbumRequest;
import se.michaelthelin.spotify.requests.data.albums.GetSeveralAlbumsRequest;
import se.michaelthelin.spotify.requests.data.artists.GetArtistRequest;
import se.michaelthelin.spotify.requests.data.artists.GetArtistsAlbumsRequest;
import se.michaelthelin.spotify.requests.data.artists.GetArtistsTopTracksRequest;
import se.michaelthelin.spotify.requests.data.artists.GetSeveralArtistsRequest;
import se.michaelthelin.spotify.requests.data.browse.GetListOfFeaturedPlaylistsRequest;
import se.michaelthelin.spotify.requests.data.browse.GetRecommendationsRequest;
import se.michaelthelin.spotify.requests.data.browse.miscellaneous.GetAvailableGenreSeedsRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetPlaylistRequest;
import se.michaelthelin.spotify.requests.data.playlists.GetPlaylistsItemsRequest;
import se.michaelthelin.spotify.requests.data.search.simplified.SearchAlbumsRequest;
import se.michaelthelin.spotify.requests.data.search.simplified.SearchArtistsRequest;
import se.michaelthelin.spotify.requests.data.search.simplified.SearchTracksRequest;
import se.michaelthelin.spotify.requests.data.tracks.GetAudioFeaturesForTrackRequest;
import se.michaelthelin.spotify.requests.data.tracks.GetTrackRequest;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.Instant;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
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
        		.limit(30)
        		.market(CountryCode.KR)
        		.build();
        return searchTracksRequest.execute().getItems();
    }
    
  //검색으로 앨범
    public AlbumSimplified[] searchAlbums(String search) throws Exception {
        ensureAccessToken();

        // 검색어 유효성 검사
        if (search == null || search.trim().isEmpty()) {
            throw new IllegalArgumentException("Search term cannot be null or empty.");
        }

        SearchAlbumsRequest searchAlbumsRequest = spotifyApi.searchAlbums(search)
                .limit(6)
                .market(CountryCode.KR)
                .build();
        return searchAlbumsRequest.execute().getItems();
    }

    
    //검색결과 없을때 랜덤 노래
    public Track[] getRandomRecommendations() throws Exception {
        ensureAccessToken();

        try {
            GetRecommendationsRequest recommendationsRequest = spotifyApi.getRecommendations()
                    .limit(36) 
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


    //트렉정보 가져오기
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
    
    //여러 트랙
    public List<Track> getTracks(List<String> trackIds) throws Exception {
        ensureAccessToken();
        List<Track> tracks = new ArrayList<>();

        for (String trackId : trackIds) {
            try {
                GetTrackRequest getTrackRequest = spotifyApi.getTrack(trackId).build();
                Track track = getTrackRequest.execute();
                tracks.add(track);
            } catch (SpotifyWebApiException | IOException | ParseException e) {
                System.err.println("Error getting track with ID " + trackId + ": " + e.getMessage());
            }
        }
        return tracks;
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

    //음악 추천 가져오기
    public List<TrackSimplified> getRecommendedTracks(float minDanceability, float maxDanceability, 
            float minEnergy, float maxEnergy, 
            float minLoudness, float maxLoudness, 
            float minTempo, float maxTempo, 
            float minValence, float maxValence,String genre) throws Exception {
    	
    		ensureAccessToken();

        
        try {
            GetRecommendationsRequest request = spotifyApi.getRecommendations()
                    .limit(5)
                    .min_danceability(minDanceability)
                    .max_danceability(maxDanceability)
                    .min_energy(minEnergy)
                    .max_energy(maxEnergy)
                    .min_loudness(minLoudness)
                    .max_loudness(maxLoudness)
                    .min_tempo(minTempo)
                    .max_tempo(maxTempo)
                    .min_valence(minValence)
                    .max_valence(maxValence)
                    .seed_genres(genre)
                    .build();

            Recommendations recommendations = request.execute();

            return Arrays.asList(recommendations.getTracks()); 
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.err.println("Error getting recommended tracks: " + e.getMessage());
            throw e;
        }
    }
    
    //장르 값들
    public List<String> getAvailableGenres() throws Exception {
        ensureAccessToken();

        GetAvailableGenreSeedsRequest genreRequest = spotifyApi.getAvailableGenreSeeds().build();
        try {
            // API 호출로 장르 목록을 가져오기
            return Arrays.asList(genreRequest.execute());
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.err.println("Error getting available genres: " + e.getMessage());
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

    //아티스트 정보
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
    
    public String getArtistIdByName(String artistName) throws Exception {
        // Access Token 갱신 확인
        ensureAccessToken();

        try {
            SearchArtistsRequest request = spotifyApi.searchArtists(artistName)
                    .limit(1) 
                    .build();
            Paging<Artist> artistPaging = request.execute();

            if (artistPaging.getItems().length > 0) {
                return artistPaging.getItems()[0].getId();
            } else {
                System.err.println("No artist found for name: " + artistName);
                return null; 
            }
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.err.println("Error searching for artist: " + e.getMessage());
            throw e;
        }
    }
    
    //아티스트들
    public List<Artist> getArtistsDetails(List<String> artistIds) throws Exception {
        ensureAccessToken();

        try {
            String[] idsArray = artistIds.toArray(new String[0]); 
            GetSeveralArtistsRequest request = spotifyApi.getSeveralArtists(idsArray).build();
            return Arrays.asList(request.execute());
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.err.println("Error getting artist details: " + e.getMessage());
            throw e;
        }
    }
    
    //아티스트로 앨범
    public AlbumSimplified[] getArtistAlbums(String artistId) {
        ensureAccessToken();
        List<AlbumSimplified> albumsList = new ArrayList<>();

        try {
            GetArtistsAlbumsRequest getArtistsAlbumsRequest = spotifyApi.getArtistsAlbums(artistId)
                .limit(9) // 원하는 만큼의 앨범 수 제한
                .build();

            Paging<AlbumSimplified> albumPaging = getArtistsAlbumsRequest.execute();
            AlbumSimplified[] albums = albumPaging.getItems();
            for (AlbumSimplified album : albums) {
                albumsList.add(album);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return albumsList.toArray(new AlbumSimplified[0]);
    }
    
    //아티스트 노래
    public List<Map<String, Object>> getArtistTopTracks(String artistId) {
        ensureAccessToken();
        List<Map<String, Object>> trackList = new ArrayList<>();

        try {
            GetArtistsTopTracksRequest topTracksRequest = spotifyApi.getArtistsTopTracks(artistId, CountryCode.KR).build();
            Track[] topTracks = topTracksRequest.execute();

            for (Track track : topTracks) {
                Map<String, Object> trackInfo = new HashMap<>();
                trackInfo.put("id",track.getId());
                trackInfo.put("name", track.getName());
                trackInfo.put("playCount", track.getPopularity());
                
                // 앨범 커버 URL 가져오기
                String albumCoverUrl = null;
                if (track.getAlbum().getImages() != null && track.getAlbum().getImages().length > 0) {
                    albumCoverUrl = track.getAlbum().getImages()[0].getUrl();
                }
                trackInfo.put("albumCover", albumCoverUrl);

                // 트랙 길이 (밀리초) 가져오기
                trackInfo.put("durationMs", track.getDurationMs());

                trackList.add(trackInfo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return trackList;
    }

    public List<Album> getAlbumsDetails(List<String> albumIds) throws Exception {
        ensureAccessToken();

        try {
            String[] idsArray = albumIds.toArray(new String[0]); 
            GetSeveralAlbumsRequest request = spotifyApi.getSeveralAlbums(idsArray).build();
            return Arrays.asList(request.execute());
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            throw e;
        }
    }


    //main에서 플레이리스트 가져올때
    public List<Playlist> getPopularPlaylists() throws Exception {
        ensureAccessToken();

        // 지정된 플레이리스트 ID 배열
        String[] playlistIds = {
                "1kaeyJkIkECBKR5uq2qi4D", // Lofi Fruits Music
                "4vvz8ZtxTvSej8GGNdvovv", // Lofi Hip Hop Music
                "1N9ssad8D7nG9KigVEqTd1", // Deep House 2022
                "6zllNrP9Qiygqyr2miF2Kb", // 80s Smash Hits
                "3jmqPjstAowLP2SymRhzLX", // 90s Hits
                "3lOwaRgxpvjkNpBPKNYuRR"  // Guardians of the Galaxy
        };

        List<Playlist> playlists = new ArrayList<>();

        // 각 ID로 Playlist 상세 정보 가져오기
        for (String playlistId : playlistIds) {
            try {
                GetPlaylistRequest request = spotifyApi.getPlaylist(playlistId).build();
                Playlist playlist = request.execute();
                playlists.add(playlist);
            } catch (SpotifyWebApiException | IOException e) {
                System.err.println("Error fetching playlist with ID: " + playlistId + ", Message: " + e.getMessage());
            }
        }

        return playlists;
    }

    //플레이리스트 가져오기
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
    
    //플레이리스트 아이디로 가져오기
    public Playlist getPlaylistById(String playlistId) throws Exception {
        ensureAccessToken(); 

        try {
            GetPlaylistRequest request = spotifyApi.getPlaylist(playlistId)
                    .build();

            return request.execute();
        } catch (SpotifyWebApiException | IOException | ParseException e) {
            System.err.println("Error getting playlist by id: " + e.getMessage());
            throw e; 
        }
    }
    
    //좋아요 음악 가져오기
    public List<Track> getSongsByIds(List<String> songIds) throws Exception {
        ensureAccessToken();
        List<Track> tracks = new ArrayList<>();

        for (String songId : songIds) {
            try {
                GetTrackRequest getTrackRequest = spotifyApi.getTrack(songId).build();
                Track track = getTrackRequest.execute();
                tracks.add(track);
            } catch (SpotifyWebApiException | IOException | ParseException e) {
                System.err.println("Error getting song with ID: " + songId + " - " + e.getMessage());
            }
        }

        return tracks;
    }
    
    //음악재생
    public String getTrackPreviewUrl(String trackId) {

        ensureAccessToken();
        
        String trackUrl = "https://api.spotify.com/v1/tracks/" + trackId;
        RestTemplate restTemplate = new RestTemplate();
        
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<Map> response = restTemplate.exchange(trackUrl, HttpMethod.GET, entity, Map.class);
        return (String) response.getBody().get("preview_url");
    }
}
