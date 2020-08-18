package com.sbs.meet.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.meet.dao.ArticleDao;
import com.sbs.meet.dto.Article;
import com.sbs.meet.util.Util;

@Service
public class ArticleService {
	@Autowired
	ArticleDao articleDao;

	public int register(Map<String, Object> param) {
		articleDao.register(param);
	int id = Util.getAsInt(param.get("id"));
	
		return id;
	}

	public Article getForPrintPrison(String searchKeyword) {
		return articleDao.getForPrintPrison(searchKeyword);
	}

	public List<Article> getForPrintArticles() {
		List<Article> articles = articleDao.getForPrintArticles();
		

		
		return articles;
	}
	
	
	
}
