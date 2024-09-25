package com.example.musicemotion.commu.web;

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
		
		CommuDTO dto = commuService.commuAll();
		
		int pageSize = 15;
		String pageNumStr = req.getParameter("pageNum");
		
		req.setAttribute("commuList", dto);
		
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
	public String commuContent(HttpServletRequest req) {
		
		return "commu/commuContent";
	}
	
	@RequestMapping("/commuDelete.do")
	public String commuDelete(HttpServletRequest req, int post_id) {
		commuService.commuDelete(post_id);
		return "redirect:commuList.do";
	}
}
