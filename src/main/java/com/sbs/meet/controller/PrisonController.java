package com.sbs.meet.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.meet.service.PrisonService;
import com.sbs.meet.util.Util;

@Controller
public class PrisonController {
	@Autowired
	PrisonService prisonService;
	
	@RequestMapping("prison/register")
	public String register() {
		return "prison/register";
	}
	
	@RequestMapping("prison/registered")
	public String registered(Model model,@RequestParam Map<String, Object> param,HttpServletRequest req) {
		
		Map<String, Object> newParam = Util.getNewMapOf(param,"nickname","tier");
//		int loginedMemberId = (int)req.getAttribute("loginedMemberId");
//		newParam.put("memberId",loginedMemberId);
		
		int newPrisonId = prisonService.register(newParam);
		
		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri",redirectUri);
		
		return "common/redirect";
	}
}
