package com.sbs.meet.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.meet.dto.Article;
import com.sbs.meet.dto.ArticleReply;

@Mapper
public interface ArticleDao  {

	void register(Map<String, Object> param);

	Article getForPrintPrison(String searchKeyword);

	List<Article> getForPrintArticles();

	Article getForPrintOneArticle(int id);

	List<ArticleReply> getForPrintArticleReplies();

	List<Article> getForPrintArticles(@RequestParam Map<String, Object> param);

	List<Article> getForPrintArticles2(int memberId);

	Article getForPrintOneUserImg(int id, int memberId);

	int getArticleInReplyCount(int id);
	
}
