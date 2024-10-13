package com.example.musicemotion.album.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/album")
public class AlbumController {

	@GetMapping("/album.do")
	public String album() {
		return "album/album";
	}
	
	@GetMapping("/albumDetail.do")
	public String albumDetail() {
		return "album/albumDetail";
	}
}
