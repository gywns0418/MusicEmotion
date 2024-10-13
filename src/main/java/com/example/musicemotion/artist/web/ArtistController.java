package com.example.musicemotion.artist.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/artist")
public class ArtistController {

	@GetMapping("/artist.do")
	public String artist() {
		return "artist/artist";
	}
	
	@GetMapping("/artistDetail.do")
	public String artistDetail() {
		return "artist/artistDetail";
	}
}
