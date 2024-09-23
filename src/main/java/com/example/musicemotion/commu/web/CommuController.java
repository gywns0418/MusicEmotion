package com.example.musicemotion.commu.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/commu")
public class CommuController {

	@GetMapping("/commuList.do")
	public String commuList() {
		return "commu/commuList";
	}
	
	@GetMapping("/addCommu.do")
	public String addCommu() {
		return "commu/addCommu";
	}
	
	@GetMapping("/editCommu.do")
	public String editCommu() {
		return "commu/editCommu";
	}
	
	@GetMapping("/commuContent.do")
	public String commuContent() {
		return "commu/commuContent";
	}
}
