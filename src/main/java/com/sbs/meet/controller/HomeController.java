package com.sbs.meet.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sbs.meet.dto.Article;
import com.sbs.meet.dto.ArticleLike;
import com.sbs.meet.dto.ArticleReply;
import com.sbs.meet.dto.File;
import com.sbs.meet.dto.Member;
import com.sbs.meet.service.ArticleService;
import com.sbs.meet.service.FileService;
import com.sbs.meet.service.MemberService;
import com.sbs.meet.service.ReplyService;
import com.sbs.meet.util.Util;

@Controller
public class HomeController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private FileService fileService;
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping("/home/main")
	public String showMain(Model model,HttpServletRequest request) {
		
		int loginedMemberId = (int) request.getAttribute("loginedMemberId");
		
		int followerCount = memberService.getFollowerCount(loginedMemberId);
		
		// 팔로우한 애들 게시글
		List<Article> articles = articleService.getForPrintArticlesInFollow(loginedMemberId);
	
		// 추천 멤버들 ( follow가 된 애들 말고 다른애들 전부 )
		
		List<Member> members = memberService.getForPrintNotFollow(loginedMemberId);
		
		// 팔로우 게시글 (댓글) 3개 보여주기
	
		List<List<ArticleReply>> articleRepliesBig = new ArrayList<>(); 
		
		for ( Article article : articles ) {
			
			int articleId = article.getId();
						
			List<ArticleReply> articleReplys = replyService.getForPrintArticleRepliesLimit3(articleId);
			
			articleRepliesBig.add(articleReplys);
		}
		
		model.addAttribute("articleRepliesBig",articleRepliesBig);
		
		
		// 팔로우 게시글 좋아요 갯수 보여주기
		List<List<Integer>> likesCountBox = new ArrayList<>();
		List<List<ArticleLike>> articleLikeBox = new ArrayList<>();
		for ( Article article : articles ) {
			
			int articleId = article.getId();
				
			List<Integer> likesCount = articleService.getLikePointByFollow(articleId);
			
			List<ArticleLike> articleLikes = articleService.getArticleLikeByFollow(articleId);
			
			for ( ArticleLike articleLike : articleLikes ) {
				int articleIdByLike = articleLike.getArticleId();
				
				if ( articleIdByLike == article.getId()) {
					
				}
			}
			
			
			likesCountBox.add(likesCount);
			articleLikeBox.add(articleLikes);
		}
		
		model.addAttribute("articleLikeBox",articleLikeBox);
		model.addAttribute("likesCountBox",likesCountBox);
		
		// 
		
		for ( Member member : members) {
			List<File> files = fileService.getFiles("member",member.getId(),"common","attachment");
			if (files.size() > 0) {
				File file = files.get(0);
				
				if ( member.getExtra() == null ) {
					member.setExtra(new HashMap<>());
				}
				
				member.getExtra().put("recomendAvatarImgUrl", "/meet/file/showImg?id=" + file.getId() + "&updateDate=" + file.getUpdateDate());
			} else {
				member.getExtra().put("recomendAvatarImgUrl", "/resource/img/avatar_no.jpg");
			}
			Map<String, File> filesMap = new HashMap<>();

			for (File file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}
		}
		
		
		
		
		for (Article article : articles) {
			List<File> files = fileService.getFiles("member", article.getMemberId(), "common", "attachment");
			if ( files.size() > 0 ) {
				File file = files.get(0);
				
				if ( article.getExtra() == null ) {
					article.setExtra(new HashMap<>());
				}
				
				article.getExtra().put("writerAvatarImgUrl", "/meet/file/showImg?id=" + file.getId() + "&updateDate=" + file.getUpdateDate());				
			}
			else {
				article.getExtra().put("writerAvatarImgUrl", "/resource/img/avatar_no.jpg");
			}
			
			Map<String, File> filesMap = new HashMap<>();

			for (File file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}
		}
		
		
		
		for ( Article article : articles ) {
			
			List<File> files = fileService.getFiles("article", article.getId(), "common", "attachment");

			Map<String, File> filesMap = new HashMap<>();

			for (File file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}

			Util.putExtraVal(article, "file__common__attachment", filesMap);
			}
		
		
		model.addAttribute("followerCount",followerCount);
		model.addAttribute("members",members);
		model.addAttribute("articles",articles);
		return "home/main";
	}
	
	@RequestMapping("home/test")
	public String showTest(String nickname) {
			
		return "home/test";
	}
	
	
		
}
