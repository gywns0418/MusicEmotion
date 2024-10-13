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

import com.example.musicemotion.dto.CommuDTO;
import com.example.musicemotion.dto.NoticeDTO;
import com.example.musicemotion.notice.service.NoticeService;

import jakarta.servlet.http.HttpServletRequest;


@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	NoticeService noticeService;

	@GetMapping("/noticeList.do")
	public String noticeList(HttpServletRequest req, @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "searchType", required = false, defaultValue = "all") String searchType) {
		List<NoticeDTO> list = noticeService.noticeAll();
		req.setAttribute("noticeList", list);
		
		 int pageSize = 10; // 한 페이지당 보여줄 게시물 수 
		 String pageNumStr = req.getParameter("pageNum"); // 현재 페이지 번호를 파라미터로 받아옴
		 
		 int pageNum = (pageNumStr == null) ? 1 : Integer.parseInt(pageNumStr); // 현재페이지 번호, 기본값은 1 
		 int totalCount;
		 if (search != null && !search.isEmpty()) { 
			 list = noticeService.searchNoticeList(searchType, search); totalCount = list.size();
		 }// 검색 결과의 전체 게시물 수 } 
		 else { 
			 totalCount = list.size(); // 전체 게시물 수 
		 }

		 int start = (pageNum - 1) * pageSize; int end = Math.min(start + pageSize, totalCount); 
		 List<NoticeDTO> paginatedList = list.subList(start, end);
		 
		 int pageCount = (int) Math.ceil((double) totalCount / pageSize); // 전체 페이지 수
		 int pageBlock = 10; // 페이지 블록 사이즈 
		 int startPage = (pageNum - 1) / pageBlock * pageBlock + 1; // 시작 페이지 번호 
		 int endPage = Math.min(startPage + pageBlock - 1, pageCount); // 끝 페이지 번호
		 
		req.setAttribute("count", totalCount); req.setAttribute("noticeList", paginatedList); // 현재 페이지에 해당하는 게시판 목록 
		req.setAttribute("pageNum", pageNum);// 현재 페이지 번호 req.setAttribute("pageCount", pageCount); // 전체 페이지 수
		req.setAttribute("startPage", startPage); // 시작 페이지 번호
		req.setAttribute("endPage", endPage); // 끝 페이지 번호 
		req.setAttribute("search", search); 
		req.setAttribute("searchType", searchType);
	
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

		return "notice/noticeList";
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
	
	@PostMapping("/noticeDelete.do")
	public String commuDelete(HttpServletRequest req, int notice_id) {
		noticeService.noticeDelete(notice_id);
		return "redirect:noticeList.do";
	}
}
