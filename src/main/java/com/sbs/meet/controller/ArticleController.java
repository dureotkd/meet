package com.sbs.meet.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.meet.dto.Article;
import com.sbs.meet.service.ArticleService;
import com.sbs.meet.util.Util;

@Controller
public class ArticleController {
	@Autowired
	ArticleService  articleService;
	
	@RequestMapping("article/register")
	public String register() {
		return "article/register";
	}
	
	@RequestMapping("article/registered")
	public String registered(Model model,@RequestParam Map<String, Object> param,HttpServletRequest req) {
		
		Map<String, Object> newParam = Util.getNewMapOf(param,"title","body","memberId");
		

		int newArticleId = articleService.register(newParam);
		
		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri",redirectUri);
		
		return "common/redirect";
	}
	
	@RequestMapping("article/list")
	public String showList(Model model,HttpServletRequest  req) {
		
		List<Article>  articles = articleService.getForPrintArticles();
		model.addAttribute("articles",articles);
		
			

		return "article/list";
	}
	
	
	
}
