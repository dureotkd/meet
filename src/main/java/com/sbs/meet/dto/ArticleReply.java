package com.sbs.meet.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ArticleReply {
	private int id;
	private int regDate;
	private int updateDate;
	private int articleId;
	private int memberId;
	private int displayStatus;
	private String body;
	private Map<String, Object> extra;
}
