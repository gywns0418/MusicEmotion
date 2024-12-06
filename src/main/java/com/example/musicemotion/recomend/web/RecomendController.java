package com.example.musicemotion.recomend.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.musicemotion.recomend.service.RecomendService;

@Controller
@RequestMapping("/recomend")
public class RecomendController {

	@Autowired
	RecomendService recomendService;
	

}
