package com.sbs.meet.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.meet.dao.ArticleDao;
import com.sbs.meet.dto.Article;
import com.sbs.meet.dto.ArticleLike;
import com.sbs.meet.dto.ArticleReply;
import com.sbs.meet.util.Util;
import com.sbs.meet.dto.File;
import com.sbs.meet.dto.Story;

@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;
	@Autowired
	private FileService fileService;
	
	// 게시글 쓰기
	
	public int doWriteArticle(Map<String, Object> param) {
		articleDao.doWriteArticle(param);
	int id = Util.getAsInt(param.get("id"));
	
	String fileIdsStr = (String) param.get("fileIdsStr");

	if (fileIdsStr != null && fileIdsStr.length() > 0) {
		List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim()))
				.collect(Collectors.toList());
		// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
		// 그것을 뒤늦게라도 이렇게 고처야 한다.
		for (int fileId : fileIds) {
			fileService.changeRelId(fileId, id);
		}
	}
	
		return id;
	} 	
	
	

	public List<Article> getForPrintArticles() {
		List<Article> articles = articleDao.getForPrintArticles();
		return articles;
	}

	public Article getForPrintOneArticle(int id) {		
		Article article = articleDao.getForPrintOneArticle(id);
		
		// 글쓴이 이미지 불러오기 !!
		// article.getMemberId() 핵심!!
		List<File> files1 = fileService.getFiles("member", article.getMemberId(), "common", "attachment");
		if ( files1.size() > 0 ) {
			File file = files1.get(0);
			
			if ( article.getExtra() == null ) {
				article.setExtra(new HashMap<>());
			}
			
			article.getExtra().put("writerAvatarImgUrl", "/meet/file/showImg?id=" + file.getId() + "&updateDate=" + file.getUpdateDate());				
		}
		else {
			article.getExtra().put("writerAvatarImgUrl", "https://scontent-cph2-1.cdninstagram.com/v/t51.2885-19/44884218_345707102882519_2446069589734326272_n.jpg?_nc_ht=scontent-cph2-1.cdninstagram.com&_nc_ohc=7xEzH-b7neEAX8-u4aK&oh=03aa0383a46332fd1b76eaa62a308799&oe=5F72988F&ig_cache_key=YW5vbnltb3VzX3Byb2ZpbGVfcGlj.2");
		}
		
		
		
		// 게시글 이미지 불러오기 !!
		
		// articlec.getId() 핵심
		List<File> files = fileService.getFiles("article", article.getId(), "common", "attachment");
		Map<String, File> filesMap = new HashMap<>();

		for (File file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		Util.putExtraVal(article, "file__common__attachment", filesMap);
		
		return article;
	}

	public List<ArticleReply> getForPrintArticleReplies() {
		return articleDao.getForPrintArticleReplies();
	}

	public List<Article> getForPrintArticles(@RequestParam Map<String, Object> param) {
		
		
		
		return articleDao.getForPrintArticles(param);
	}

	public List<Article> getForPrintArticles2(int memberId) {
		
		List<Article> articles = articleDao.getForPrintArticles2(memberId);
		
		for ( Article article : articles ) {
			
			List<File> files = fileService.getFiles("article", article.getId(), "common", "attachment");
			Map<String, File> filesMap = new HashMap<>();

			for (File file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}

			Util.putExtraVal(article, "file__common__attachment", filesMap);
		}		
		return articles;
	}
	// 유저 이미지 띄우기.
	public Article getForPrintUserImg(int articleId, int memberId) {
		Article article = articleDao.getForPrintOneUserImg(articleId, memberId);
		
		List<File> files = fileService.getFiles("member", article.getMemberId(), "common", "attachment");
		Map<String, File> filesMap = new HashMap<>();

		for (File file : files) {
			filesMap.put(file.getFileNo() + "", file);
		}

		Util.putExtraVal(article, "file__common__attachment", filesMap);
		
		return article;
	}

	public int getArticleReplyCount() {
		return articleDao.getArticleReplyCount();
	}

	public Map<String, Object> getArticleLikeAvailable(int id, int loginedMemberId) {
		
		// 게시글 하나 가저와서
		Article article = articleDao.getForPrintOneArticle(id);

		Map<String, Object> rs = new HashMap<>();
		
		// article.getMemberId 랑 loginId 랑 같으면 본인 추천 x
		if (article.getMemberId() == loginedMemberId) {
			rs.put("resultCode", "F-1");
			rs.put("msg", "본인은 추천 할 수 없습니다.");
			return rs;
		}
		
		
		//  좋아요 중복 방지 체크.
		int likePoint = articleDao.getLikePointByMemberId(id,loginedMemberId);
		
		if (likePoint > 0) {
			rs.put("resultCode", "F-2");
			articleDao.cancleLikeAction(id,loginedMemberId);
			return rs;
		}
		
		// 가능
		rs.put("resultCode", "S-1");
		rs.put("msg", "가능합니다.");

		return rs;
	}

	public Map<String, Object> likeArticle(int id, int loginedMemberId) {
		
		articleDao.likeArticle(id,loginedMemberId);
		
		Map<String, Object> rs = new HashMap<>();
		
		rs.put("resultCode","S-1");
		return rs;
	}

	public int getArticleCount(int memberId) {
		return articleDao.getArticleCount(memberId);
	}

	public int getLikePoint(int id) {
		return articleDao.getLikePoint(id);
	}

	public int getArticleLikeAvailableCount(int id, int loginedMemberId) {
		return articleDao.getArticleLikeAvailableCount(id,loginedMemberId);
	}



	public List<ArticleLike> getForPrintArticleLikesByMyArticle(int loginedMemberId) {
		return articleDao.getForPrintArticleLikesByMyArticle(loginedMemberId);
	}



	public int getArticlesLikeCount(int id) {
		return articleDao.getArticlesLikeCount(id);
	}



	public Article getLikeKing() {
		return articleDao.getLikeKing();
	}



	public List<Article> getLikeKingLimitFive() {
		return articleDao.getLikeKingLimitFive();
	}



	public Map<String, Object> updateReadStatus(int id) {
		return articleDao.updateReadStatus(id);
	}



	public List<Article> getForPrintArticlesInFollow(int loginedMemberId){
		return articleDao.getForPrintArticlesInFollow(loginedMemberId);
	}



	public void doDeleteReplyAjax(int id) {
		 articleDao.doDeleteReplyAjax(id);
	}



	public List<Article> getForPrintArticleByLikeKing(int memberId) {
		return articleDao.getForPrintArticleByLikeKing(memberId);
	}



	public void doDeleteArticleAjax(int id) {
		articleDao.doDeleteArticleAjax(id);
	}



	public List<Article> getForPrintArticles3(int memberId) {
		List<Article> articles = articleDao.getForPrintArticles3(memberId);
		
		for ( Article article : articles ) {
			
			List<File> files = fileService.getFiles("article", article.getId(), "common", "attachment");
			Map<String, File> filesMap = new HashMap<>();

			for (File file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}

			Util.putExtraVal(article, "file__common__attachment", filesMap);
		}		
		return articles;
	}



	public Map<String, Object> cancleLike(int id, int loginedMemberId) {
		
		
		articleDao.cancleLikeAction(id,loginedMemberId);
		
		Map<String, Object> rs = new HashMap<>();
		
		rs.put("resultCode","S-1");
		
		return rs;
	}



	public Map<String, Object> getArticleCancelLikeAvailable(int id, int loginedMemberId) {
		// 게시글 하나 가저와서
		Article article = articleDao.getForPrintOneArticle(id);

		Map<String, Object> rs = new HashMap<>();
		
		// 가능
		rs.put("resultCode", "S-1");
		rs.put("msg", "가능합니다.");

		return rs;
	}



	public List<Integer> getLikePointByMeAndList(int id, int loginedMemberId) {
		return articleDao.getLikePointByMemberIdAndList(id, loginedMemberId);
	}
	
	public int getLikePointByMe(int id, int loginedMemberId) {
		return articleDao.getLikePointByMemberId(id, loginedMemberId);
	}



	public List<Integer> getLikePointByFollow(int articleId) {
		return articleDao.getLikePointByFollow(articleId);
	}



	public List<ArticleLike> getArticleLikeByFollow(int articleId) {
		return articleDao.getArticleLikeByFollow(articleId);
	}



	public int doWriteStory(Map<String, Object> param) {
		articleDao.doWriteStory(param);
		int id = Util.getAsInt(param.get("id"));
		
		String fileIdsStr = (String) param.get("fileIdsStr");

		if (fileIdsStr != null && fileIdsStr.length() > 0) {
			List<Integer> fileIds = Arrays.asList(fileIdsStr.split(",")).stream().map(s -> Integer.parseInt(s.trim()))
					.collect(Collectors.toList());
			// 파일이 먼저 생성된 후에, 관련 데이터가 생성되는 경우에는, file의 relId가 일단 0으로 저장된다.
			// 그것을 뒤늦게라도 이렇게 고처야 한다.
			for (int fileId : fileIds) {
				fileService.changeRelId(fileId, id);
			}
		}
		
			return id;
	}



	public List<Story> getForPrintStroiesInFollow(int loginedMemberId) {	
		return articleDao.getForPrintStroiesInFollow(loginedMemberId);
	}



	public void increaseHit(int id) {
		articleDao.increaseHit(id);
	}



	public List<Story> getForPrintStroies(int memberId) {
		return articleDao.getForPrintStories(memberId);
	}




	
	
}
