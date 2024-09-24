package com.example.musicemotion.notice.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@GetMapping("/noticeList.do")
	public String noticeList() {
		return "notice/noticeList";
	}
	
	@GetMapping("/addNotice.do")
	public String addNotice() {
		return "notice/addNotice";
	}
	
	@GetMapping("/editNotice.do")
	public String editNotice() {
		return "notice/editNotice";
	}
	
	@GetMapping("/noticeContent.do")
	public String noticeContent() {
		return "notice/noticeContent";
	}
}
