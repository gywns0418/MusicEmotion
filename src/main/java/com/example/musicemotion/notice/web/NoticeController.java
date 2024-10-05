package com.example.musicemotion.notice.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.musicemotion.dto.NoticeDTO;
import com.example.musicemotion.notice.service.NoticeService;

import jakarta.servlet.http.HttpServletRequest;


@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;

	@GetMapping("/noticeList.do")
	public String noticeList(HttpServletRequest req) {
		List<NoticeDTO> list = noticeService.noticeAll();
		req.setAttribute("noticeList", list);
		
		return "notice/noticeList";
	}
	
	@GetMapping("/addNotice.do")
	public String addNotice() {
		return "notice/addNotice";
	}
	
	@PostMapping("/addNotice.do")
	public String addNotice(HttpServletRequest req, NoticeDTO dto) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        
		System.out.println("member : " + dto.getMember_name());
		System.out.println("title : " + dto.getTitle());
		System.out.println("content : " + dto.getContent());

		noticeService.noticeWrite(dto);

		return "redirect:noticeList.do";
	}
	
	@GetMapping("/editNotice.do")
	public String editNotice(HttpServletRequest req, @RequestParam int notice_id) {
		NoticeDTO dto = noticeService.getNoticeId(notice_id);
		req.setAttribute("editNotice", dto);
		
		return "notice/editNotice";
	}
	
	@PostMapping("/editNotice.do")
	public String noticeUpdate(@ModelAttribute NoticeDTO dto) {
		
		System.out.println("notice_id : " + dto.getNotice_id());
		System.out.println("member : " + dto.getMember_name());
		System.out.println("title : " + dto.getTitle());
		System.out.println("content : " + dto.getContent());

		noticeService.noticeUpdate(dto);

		return "redirect:noticeList.do";

	}
	
	@GetMapping("/noticeContent.do")
	public String noticeContent(HttpServletRequest req, @RequestParam int notice_id) {
		NoticeDTO dto = noticeService.getNoticeId(notice_id);
		req.setAttribute("noticeId", dto);
		return "notice/noticeContent";
	}
	
	@RequestMapping("/noticeDelete.do")
	public String commuDelete(HttpServletRequest req, int notice_id) {
		noticeService.noticeDelete(notice_id);
		return "redirect:noticeList.do";
	}
}
