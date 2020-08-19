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
import com.sbs.meet.dto.ArticleReply;
import com.sbs.meet.service.ArticleService;

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
		
		int newArticleId = articleService.register(param);
		
		String redirectUri = (String) param.get("redirectUri");
		redirectUri = redirectUri.replace("#id", newArticleId + "");
		
		return "redirect:" + redirectUri;
	}
	
	@RequestMapping("article/list")
	public String showList(Model model,HttpServletRequest  req) {
		
		List<Article>  articles = articleService.getForPrintArticles();
		model.addAttribute("articles",articles);

		return "article/list";
	}
	
	@RequestMapping("article/detail")
	public String showDetail(Model model,@RequestParam Map<String, Object> param) {
		
		int id = Integer.parseInt((String) param.get("id"));
		
		Article article = articleService.getForPrintOneArticle(id);
		List<ArticleReply> articleReplies = articleService.getForPrintArticleReplies();
		model.addAttribute("article",article);
		model.addAttribute("articleReplies",articleReplies);
		
		return "article/detail";
	}
	
	
	
}
