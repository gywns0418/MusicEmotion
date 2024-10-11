package com.example.musicemotion;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.musicemotion.dto.EmotionDTO;
import com.example.musicemotion.emotion.service.EmotionService;

import jakarta.servlet.http.HttpServletRequest;



@Controller
public class MainController {

	@Autowired
	EmotionService emotionService;
	
    @RequestMapping(value="/")
    public String Home(HttpServletRequest req) {
    	List<EmotionDTO> emotion = emotionService.emotionAll();
    	req.setAttribute("emotion", emotion);
    	
        return "main";
    }
    

}
