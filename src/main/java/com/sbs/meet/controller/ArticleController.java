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
import com.sbs.meet.dto.ArticleReply;
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
	
	// 사진만 
	
	@RequestMapping("/article/list")
	public String showList(Model model,@RequestParam Map<String, Object> param) {
		List<Article>  articles = articleService.getForPrintArticles();
		
		
		List<ArticleReply> articleReply = articleService.getForPrintArticleReplies();
		
		
		
		
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
		model.addAttribute("articleReply",articleReply);
		model.addAttribute("articles",articles);
		// model.addAttribute("ArticleInReplyCount",ArticleInReplyCount);
		return "article/list";
	}
	
	// 비디오만 
	@RequestMapping("article/videoList")
	public String showVideoList(Model model,@RequestParam Map<String, Object> param) {
		List<Article> articles = articleService.getForPrintArticles();
		
		for ( Article article : articles ) {
			
			List<File> files = fileService.getFiles("article",article.getId(),"common","attachment");
			 
			Map<String, File> filesMap = new HashMap<>();
			
			for (File file : files) {
				filesMap.put(file.getFileNo() + "",file);
			}
			
			Util.putExtraVal(article,"file__common__attachment",filesMap);
		}
		
		for ( Article article : articles) {
			List<File> files = fileService.getFiles("member",article.getMemberId(),"common","attachment");
			
			if ( files.size() > 0 ) {
				File file = files.get(0);
				
				if ( article.getExtra() == null) {
					article.setExtra(new HashMap<>());
				}
				article.getExtra().put("writerAvatarImgUrl","/file/showImg?id=" +file.getId() +"&updateDate ="+file.getUpdateDate());
			} else {
				article.getExtra().put("writerAvatarImgUrl","/resource/img/avatar_no.jpg");
			}
			
			Map<String, File> filesMap = new HashMap<>();
			
			for (File file : files) {
				filesMap.put(file.getFileNo() + "",file);
			}
		}
		
		model.addAttribute("articles",articles);
		return "article/videoList";
	}
	

	// 디테일 
	
	@RequestMapping("article/detail")
	public String showDetail(Model model,@RequestParam Map<String, Object> param) {
		
		int id = Integer.parseInt((String) param.get("id"));

		Article article = articleService.getForPrintOneArticle(id);
		// 게시글
		model.addAttribute("article",article);

		return "article/detail";
	}
	
	// 좋아요 
	
	@RequestMapping("article/doLike")
	public String doLike(Model model,int id,HttpServletRequest request,String redirectUri) {
		
		int loginedMemberId = (int) request.getAttribute("loginedMemberId");
		
		// 중복 추천 체크
		Map<String, Object> articleLikeAvailableRs = articleService.getArticleLikeAvailable(id,loginedMemberId);
		
		if (((String) articleLikeAvailableRs.get("resultCode")).startsWith("F-")) {
			model.addAttribute("alertMsg", articleLikeAvailableRs.get("msg"));
			model.addAttribute("historyBack", true);
			return "common/redirect";
		}
		
		// 좋아요 Start
		Map<String, Object> rs = articleService.likeArticle(id,loginedMemberId);
		
		String msg = (String) rs.get("msg");
		
		model.addAttribute("alertMsg",msg);
		model.addAttribute("redirectUri",redirectUri);
		return "common/redirect";
	}
	
	@RequestMapping("article/textList")
	public String showTextList(Model model) {
		
		List<Article> articles = articleService.getForPrintArticles();
		
		
		model.addAttribute("articles",articles);
		
		return "article/textList";
	}
	
	
	
	
	
}
