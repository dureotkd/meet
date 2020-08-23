package com.sbs.meet.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.meet.dto.Article;
import com.sbs.meet.dto.File;
import com.sbs.meet.service.ArticleService;
import com.sbs.meet.service.FileService;
import com.sbs.meet.util.Util;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService  articleService;
	@Autowired
	private FileService fileService;
	
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
	
	@RequestMapping("/article/list")
	public String showList(Model model,@RequestParam Map<String, Object> param) {
		List<Article>  articles = articleService.getForPrintArticles();
	
		
		// int ArticleInReplyCount = articleService.getArticleInReplyCount(id);
		
		
		for ( Article article : articles ) {
			
		List<File> files = fileService.getFiles("article", article.getId(), "common", "attachment");
		Map<String, File> filesMap = new HashMap<>();

		for (File file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		Util.putExtraVal(article, "file__common__attachment", filesMap);
		}
		

		// 작성자
		
		for (Article article : articles) {
			List<File> files = fileService.getFiles("member", article.getMemberId(), "common", "attachment");
			if ( files.size() > 0 ) {
				File file = files.get(0);
				
				if ( article.getExtra() == null ) {
					article.setExtra(new HashMap<>());
				}
				
				article.getExtra().put("writerAvatarImgUrl", "/file/showImg?id=" + file.getId() + "&updateDate=" + file.getUpdateDate());				
			}
			else {
				article.getExtra().put("writerAvatarImgUrl", "/resource/img/avatar_no.jpg");
			}
			
			Map<String, File> filesMap = new HashMap<>();

			for (File file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}
		}
		
		model.addAttribute("articles",articles);
		// model.addAttribute("ArticleInReplyCount",ArticleInReplyCount);
		return "article/list";
	}
	

	
	@RequestMapping("article/detail")
	public String showDetail(Model model,@RequestParam Map<String, Object> param) {
		
		int id = Integer.parseInt((String) param.get("id"));

		Article article = articleService.getForPrintOneArticle(id);
		// 게시글
		model.addAttribute("article",article);

		return "article/detail";
	}
	
	
	
	
	
}
