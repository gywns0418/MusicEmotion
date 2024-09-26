package com.example.musicemotion.commu.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.musicemotion.commu.service.CommuService;
import com.example.musicemotion.dto.CommuDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/commu")
public class CommuController {
	
	@Autowired
	CommuService commuService;

	@GetMapping("/commuList.do")
	public String commuList(HttpServletRequest req, @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "searchType", required = false, defaultValue = "all") String searchType) {
		
		List<CommuDTO> list = commuService.commuAll();
		req.setAttribute("commuList", list);
		
		int pageSize = 15; // 한 페이지당 보여줄 게시물 수
	    String pageNumStr = req.getParameter("pageNum"); // 현재 페이지 번호를 파라미터로 받아옴

	    int pageNum = (pageNumStr == null) ? 1 : Integer.parseInt(pageNumStr); // 현재 페이지 번호, 기본값은 1
	    int totalCount;
	    
	    if (search != null && !search.isEmpty()) {
	    	list = commuService.searchCommuList(searchType, search);
            totalCount = list.size(); // 검색 결과의 전체 게시물 수
        } else {
            totalCount = list.size(); // 전체 게시물 수
        }
		
	    int start = (pageNum - 1) * pageSize;
	    int end = Math.min(start + pageSize, totalCount);
	    List<CommuDTO> paginatedList = list.subList(start, end);
	    
	    int pageCount = (int) Math.ceil((double) totalCount / pageSize); // 전체 페이지 수
	    int pageBlock = 15; // 페이지 블록 사이즈
	    int startPage = (pageNum - 1) / pageBlock * pageBlock + 1; // 시작 페이지 번호
	    int endPage = Math.min(startPage + pageBlock - 1, pageCount); // 끝 페이지 번호

	    req.setAttribute("count", totalCount);
	    req.setAttribute("commuList", paginatedList); // 현재 페이지에 해당하는 게시판 목록
	    req.setAttribute("pageNum", pageNum); // 현재 페이지 번호
	    req.setAttribute("pageCount", pageCount); // 전체 페이지 수
	    req.setAttribute("startPage", startPage); // 시작 페이지 번호
	    req.setAttribute("endPage", endPage); // 끝 페이지 번호
	    req.setAttribute("search", search);
	    req.setAttribute("searchType", searchType);
		
		return "commu/commuList";
	}
	
	@GetMapping("/addCommu.do")
	public String addCommu() {
		return "commu/addCommu";
	}
	
	@PostMapping("/addCommu.do")
	public String addCommu(HttpServletRequest req, CommuDTO dto) {
		commuService.commuWrite(dto);
		
		return "redirect:commuList.do";
	}
	
	
	@GetMapping("/editCommu.do")
	public String editCommu(HttpServletRequest req,@RequestParam int post_id) {
		CommuDTO dto = commuService.getCommuId(post_id);
		req.setAttribute("editCommu", dto);
		return "commu/editCommu";
	}
	
	@PostMapping("/editCommu.do")
	public String commuUpdate(@ModelAttribute CommuDTO dto) {
		
		commuService.commuUpdate(dto);
		return "redirect:commuList.do";

	}
	
	@GetMapping("/commuContent.do")
	public String commuContent(HttpServletRequest req,@RequestParam int post_id) {
		CommuDTO dto = commuService.getCommuId(post_id);
		req.setAttribute("editCommu", dto);
		return "commu/commuContent";
	}
	
	@RequestMapping("/commuDelete.do")
	public String commuDelete(HttpServletRequest req, int post_id) {
		commuService.commuDelete(post_id);
		return "redirect:commuList.do";
	}
}
