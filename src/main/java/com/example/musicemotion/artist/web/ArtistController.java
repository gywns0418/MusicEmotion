package com.example.musicemotion.artist.web;

import java.util.HashMap;
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



@Controller
@RequestMapping("/artist")
public class ArtistController {
	
    @Autowired
    ArtistService artistService;

	@GetMapping("/artist.do")
	public String artist() {
		return "artist/artist";
	}
	
	@GetMapping("/artistDetail.do")
	public String artistDetail() {
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
