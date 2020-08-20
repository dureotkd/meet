package com.sbs.meet.service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.meet.dao.ArticleDao;
import com.sbs.meet.dto.Article;
import com.sbs.meet.dto.ArticleReply;
import com.sbs.meet.util.Util;
import com.sbs.meet.dto.File;

@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;
	@Autowired
	private FileService fileService;

	public int register(Map<String, Object> param) {
		articleDao.register(param);
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

	public Article getForPrintPrison(String searchKeyword) {
		return articleDao.getForPrintPrison(searchKeyword);
	}

	public List<Article> getForPrintArticles() {
		List<Article> articles = articleDao.getForPrintArticles();
		return articles;
	}

	public Article getForPrintOneArticle(int id) {		
		Article article = articleDao.getForPrintOneArticle(id);
		
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
	
	
	
}
