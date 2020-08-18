package com.sbs.meet.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.meet.dto.Prison;
import com.sbs.meet.service.PrisonService;
import com.sbs.meet.util.Util;

@Controller
public class HomeController {
	@Autowired
	PrisonService prisonService;
	
	
	@RequestMapping("/home/main")
	public String showMain() {
		return "home/main";
	}
	
	@RequestMapping("/home/detail")
	public String showDetail(@RequestParam Map<String, Object> param,HttpServletRequest req,Model model) {
		

	
	String searchKeyword = "";
	
	if (!Util.empty(req, "searchKeyword")) {
		searchKeyword = Util.getString(req, "searchKeyword");
	}
	
	Prison prison = prisonService.getForPrintPrison(searchKeyword);
	
	model.addAttribute("prison",prison);

	
	return "prison/detail";
		
	}
	
	
}
