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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.meet.dto.Article;
import com.sbs.meet.dto.File;
import com.sbs.meet.dto.Member;
import com.sbs.meet.dto.Story;
import com.sbs.meet.service.ArticleService;
import com.sbs.meet.service.FileService;
import com.sbs.meet.service.MemberService;
import com.sbs.meet.service.ReplyService;
import com.sbs.meet.util.Util;

@Controller
public class ArticleController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private FileService fileService;
	@Autowired
	private MemberService memberService;

	// write.jsp 연결

	@RequestMapping("article/write")
	public String showWriteForm(Model model, HttpServletRequest request) {
		
		int memberId =  (int) request.getAttribute("loginedMemberId");
		
		Member member = memberService.getMemberById(memberId);

		int articleCount = articleService.getArticleCount(memberId);

		if (articleCount >= 5 && articleCount < 10) {
			memberService.doUpdateLevel5(memberId);
		}

		if (articleCount >= 10) {
			memberService.doUpdateLevel10(memberId);
		}
		
		
		model.addAttribute("articleCount", articleCount);
		return "article/write";

	}

	// form Action 으로 부터 파라미터 받아서 본격적으로 실행.

	@RequestMapping("article/doWriteArticle")
	public String registered(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req) {

		int newArticleId = articleService.doWriteArticle(param);

		String redirectUri = (String) param.get("redirectUri");
		redirectUri = redirectUri.replace("#id", newArticleId + "");

		return "redirect:" + redirectUri;
	}

	@RequestMapping("article/doWriteStory")
	public String doWriteStory(Model model, @RequestParam Map<String, Object> param, HttpServletRequest req) {

		int newStoryId = articleService.doWriteStory(param);

		String redirectUri = (String) param.get("redirectUri");

		return "redirect:" + redirectUri;
	}

	//

	@RequestMapping("/article/imgList")
	public String showImgList(Model model, HttpServletRequest request, @RequestParam Map<String, Object> param) {

		List<Article> articles = articleService.getForPrintArticles();

		int loginedMemberId = (int) request.getAttribute("loginedMemberId");

		// 게시글 사진 전체 불러오기 
		for (Article article : articles) {

			List<File> files = fileService.getFiles("article", article.getId(), "common", "attachment");
			Map<String, File> filesMap = new HashMap<>();

			for (File file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}

			int id = article.getId();

			List<Integer> confirmLikePointList = articleService.getLikePointByMeAndList(id, loginedMemberId);

			model.addAttribute("confirmLikePointList", confirmLikePointList);

			Util.putExtraVal(article, "file__common__attachment", filesMap);
		}

		model.addAttribute("articles", articles);
		return "article/imgList";
	}

	// 비디오만
	@RequestMapping("article/videoList")
	public String showVideoList(Model model, @RequestParam Map<String, Object> param) {
		List<Article> articles = articleService.getForPrintArticles();

		// 게시글 동영상 불러오기 relid = article.getId()

		for (Article article : articles) {

			List<File> files = fileService.getFiles("article", article.getId(), "common", "attachment");

			Map<String, File> filesMap = new HashMap<>();

			for (File file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}

			Util.putExtraVal(article, "file__common__attachment", filesMap);
		}

		model.addAttribute("articles", articles);
		return "article/videoList";
	}

	// 게시글 디테일

	@RequestMapping("article/detail")
	public String showArticlecDetail(Model model, @RequestParam Map<String, Object> param, int id,
			HttpServletRequest request) {
		
		// 디테일 게시글
		Article article = articleService.getForPrintOneArticle(id);

		int memberId = article.getMemberId();
		
		// 유저 게시글 더보기
		List<Article> articles = articleService.getForPrintArticles3(memberId);

		int loginedMemberId = (int) request.getAttribute("loginedMemberId");

		// 팔로잉중인지 확인
		int following = memberService.getFollowingConfirm(memberId, loginedMemberId);
		int followCross = memberService.getFollowCross(memberId, loginedMemberId);
		//
		
		// 좋아요 확인
		int confirmLikePoint = articleService.getLikePointByMe(id, loginedMemberId);

		model.addAttribute("confirmLikePoint", confirmLikePoint);
		
		// 유저 정보
		Member member = memberService.getMemberById(memberId);

		model.addAttribute("followCross", followCross);
		model.addAttribute("following", following);
		model.addAttribute("article", article);
		model.addAttribute("articles", articles);
		model.addAttribute("member", member);

		return "article/detail";
	}

	// 좋아요

	@RequestMapping("article/doLike")
	@ResponseBody
	public Map<String, Object> doLike(Model model, int id, HttpServletRequest request) {

		int loginedMemberId = (int) request.getAttribute("loginedMemberId");

		Map<String, Object> rs = new HashMap<>();

		// 중복 추천 체크
		Map<String, Object> articleLikeAvailableRs = articleService.getArticleLikeAvailable(id, loginedMemberId);

		if (((String) articleLikeAvailableRs.get("resultCode")).startsWith("F-")) {
			rs.put("resultCode", articleLikeAvailableRs.get("resultCode"));
			rs.put("msg", articleLikeAvailableRs.get("msg"));

			return rs;
		}

		// 좋아요 Start
		Map<String, Object> likeArticleRs = articleService.likeArticle(id, loginedMemberId);
		String resultCode = (String) likeArticleRs.get("resultCode");
		int likePoint = articleService.getLikePoint(id);

		int articleLikeAvailableCount = articleService.getArticleLikeAvailableCount(id, loginedMemberId);
		rs.put("resultCode", resultCode);
		rs.put("likePoint", likePoint);

		return rs;
	}

	@RequestMapping("article/cancleLike")
	@ResponseBody
	public Map<String, Object> cancleLike(int id, HttpServletRequest request) {

		Map<String, Object> rs = new HashMap<>();
		int loginedMemberId = (int) request.getAttribute("loginedMemberId");

		Map<String, Object> articleCancelLikeAvailableRs = articleService.getArticleCancelLikeAvailable(id,
				loginedMemberId);

		if (((String) articleCancelLikeAvailableRs.get("resultCode")).startsWith("F-")) {
			rs.put("resultCode", articleCancelLikeAvailableRs.get("resultCode"));
			rs.put("msg", articleCancelLikeAvailableRs.get("msg"));

			return rs;
		}

		Map<String, Object> cancelLikeArticleRs = articleService.cancleLike(id, loginedMemberId);

		String resultCode = (String) cancelLikeArticleRs.get("resultCode");
		String msg = (String) cancelLikeArticleRs.get("msg");

		int likePoint = articleService.getLikePoint(id);

		rs.put("resultCode", resultCode);
		rs.put("msg", msg);
		rs.put("likePoint", likePoint);

		return rs;
	}

	@RequestMapping("article/getLikeCount")
	@ResponseBody
	public Map<String, Object> getLikeCount(Model model, int id) {

		int articlesLikeCount = articleService.getArticlesLikeCount(id);

		Map<String, Object> rs = new HashMap<>();
		rs.put("articleLikeCount", articlesLikeCount);
		return rs;
	}

	@RequestMapping("article/doDeleteReplyAjax")
	public void doDeleteReplyAjax(int id, HttpServletRequest request) {
		articleService.doDeleteReplyAjax(id);
	}

	@RequestMapping("article/doDeleteArticleAjax")
	public void doDeleteArticleAjax(int id) {
		articleService.doDeleteArticleAjax(id);
	}

	// text 만 할지 안할지 고민중.

	@RequestMapping("article/textList")
	public String showTextList(Model model) {

		List<Article> articles = articleService.getForPrintArticles();

		for (Article article : articles) {

			List<File> files = fileService.getFiles("article", article.getId(), "common", "attachment");
			Map<String, File> filesMap = new HashMap<>();

			for (File file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}

			Util.putExtraVal(article, "file__common__attachment", filesMap);
		}

		for (Article article : articles) {

			List<File> files = fileService.getFiles("article", article.getId(), "common", "attachment");

			Map<String, File> filesMap = new HashMap<>();

			for (File file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}

			Util.putExtraVal(article, "file__common__attachment", filesMap);
		}

		for (Article article : articles) {
			List<File> files = fileService.getFiles("member", article.getMemberId(), "common", "attachment");
			if (files.size() > 0) {
				File file = files.get(0);

				if (article.getExtra() == null) {
					article.setExtra(new HashMap<>());
				}
				article.getExtra().put("writerAvatarImgUrl",
						"/meet/file/showImg?id=" + file.getId() + "&updateDate=" + file.getUpdateDate());
			} else {
				article.getExtra().put("writerAvatarImgUrl",
						"https://scontent-cph2-1.cdninstagram.com/v/t51.2885-19/44884218_345707102882519_2446069589734326272_n.jpg?_nc_ht=scontent-cph2-1.cdninstagram.com&_nc_ohc=7xEzH-b7neEAX8-u4aK&oh=03aa0383a46332fd1b76eaa62a308799&oe=5F72988F&ig_cache_key=YW5vbnltb3VzX3Byb2ZpbGVfcGlj.2");
			}

			Map<String, File> filesMap = new HashMap<>();

			for (File file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}
		}

		model.addAttribute("articles", articles);

		return "article/textList";
	}

	@RequestMapping("article/increaseHit")
	@ResponseBody
	public void increaseHit(int id) {
		articleService.increaseHit(id);
	}

}
