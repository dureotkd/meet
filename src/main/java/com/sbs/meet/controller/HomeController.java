package com.sbs.meet.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.meet.util.Util;

@Controller
public class HomeController {

	
	@RequestMapping("/home/main")
	public String showMain() {
		return "home/main";
	}
	
		
}
