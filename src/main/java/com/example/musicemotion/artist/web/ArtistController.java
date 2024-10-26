package com.example.musicemotion.artist.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.musicemotion.artist.service.ArtistService;
import com.example.musicemotion.dto.ArtistDTO;
import com.example.musicemotion.spotify.service.SpotifyService;

import jakarta.servlet.http.HttpServletRequest;
import se.michaelthelin.spotify.model_objects.specification.AlbumSimplified;
import se.michaelthelin.spotify.model_objects.specification.Artist;
import se.michaelthelin.spotify.model_objects.specification.Track;



@Controller
@RequestMapping("/artist")
public class ArtistController {
	
    @Autowired
    ArtistService artistService;
    
    @Autowired
    SpotifyService spotifyService;

	@GetMapping("/artist.do")
	public String artist(HttpServletRequest req) throws Exception {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String username = authentication.getName();

	    // 팔로우한 아티스트 목록 조회
	    List<String> followedArtists = artistService.artistIdAll(username);
	    System.out.println("followedArtists : " + followedArtists);
	    
	    List<Artist> artistList = spotifyService.getArtistsDetails(followedArtists);
	    System.out.println("artistList : " + artistList.get(0));
	    req.setAttribute("artistList", artistList);
	    
		return "artist/artist";
	}
	
	@GetMapping("/artistDetail.do")
	public String artistDetail(HttpServletRequest req) {
	    String artistId = req.getParameter("artist_id");
	    
	    // 사용자 정보 가져오기
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String username = authentication.getName();

	    try {
	        // 아티스트 세부 정보 가져오기
	        Artist artistDetail = spotifyService.getArtistDetail(artistId);
	        req.setAttribute("artistDetail", artistDetail);

	        // 아티스트 이미지 설정
	        String artistImageUrl = (artistDetail.getImages() != null && artistDetail.getImages().length > 0) ?
	                artistDetail.getImages()[0].getUrl() : null;
	        req.setAttribute("artistImageUrl", artistImageUrl);

	        // 장르 정보 설정
	        String artistGenre = (artistDetail.getGenres() != null && artistDetail.getGenres().length > 0) ?
	                artistDetail.getGenres()[0] : "장르 정보 없음";
	        req.setAttribute("artistGenre", artistGenre);

	        // 인기도 및 팔로워 수 설정
	        req.setAttribute("popularity", artistDetail.getPopularity());
	        req.setAttribute("followers", artistDetail.getFollowers().getTotal());

	        // 인기 트랙 목록 설정
	        List<Map<String, Object>> popularTracks = spotifyService.getArtistTopTracks(artistId);
	        req.setAttribute("popularTracks", popularTracks);

	        // 앨범 목록 설정
	        AlbumSimplified[] albums = spotifyService.getArtistAlbums(artistId);
	        req.setAttribute("albums", albums);

	        // 사용자 팔로우 여부 설정
	        ArtistDTO artistDTO = new ArtistDTO();
	        artistDTO.setArtist_id(artistId);
	        artistDTO.setUser_id(username);
	        
	        List<String> followedArtistIds = artistService.artistId(artistDTO);
	        req.setAttribute("followedArtistIds", followedArtistIds);

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return "artist/artistDetail";
	}




	


	@PostMapping("/follow")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> followArtist(@RequestBody Map<String, Object> payload) {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    String username = authentication.getName();

	    String artistId = (String) payload.get("artist_id");
	    boolean following = (boolean) payload.get("following");

	    ArtistDTO dto = new ArtistDTO();
	    dto.setUser_id(username);
	    dto.setArtist_id(artistId);

	    boolean success;
	    try {
	        success = following ? artistService.addArtist(dto) : artistService.deleteArtist(dto);
	    } catch (Exception e) {
	        e.printStackTrace();
	        success = false;
	    }

	    Map<String, Object> response = new HashMap<>();
	    response.put("success", success);
	    return ResponseEntity.ok(response);
	}

}
