package com.sbs.meet.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.meet.dto.Article;

@Mapper
public interface ArticleDao  {

	void register(Map<String, Object> param);

	Article getForPrintPrison(String searchKeyword);

	List<Article> getForPrintArticles();
	
}
