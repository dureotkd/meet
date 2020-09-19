package com.sbs.meet.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.meet.dto.ArticleReply;
import com.sbs.meet.dto.File;
import com.sbs.meet.dto.ResultData;
import com.sbs.meet.service.ArticleService;
import com.sbs.meet.service.FileService;
import com.sbs.meet.service.ReplyService;

@Controller
public class ReplyController {
	@Autowired
	private ReplyService replyService;
	@Autowired
	private FileService fileService;

	@RequestMapping("/reply/doWriteReplyAjax")
	@ResponseBody
	public void doWriteReplyAjax(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		Map<String, Object> rsDataBody = new HashMap<>();

		param.put("memberId", req.getAttribute("loginedMemberId"));

		replyService.writeReply(param);
		replyService.increaseReplyCount(param);
	}

	@RequestMapping("/reply/getForPrintRepliesAjax")
	@ResponseBody
	public ResultData getForPrintRepliesAjax(@RequestParam Map<String, Object> param) {

		List<ArticleReply> articleReplies = replyService.getForPrintArticleReplies(param);

		for (ArticleReply articleReply : articleReplies) {
			List<File> files = fileService.getFiles("member", articleReply.getMemberId(), "common", "attachment");
			if (files.size() > 0) {
				File file = files.get(0);

				if (articleReply.getExtra() == null) {
					articleReply.setExtra(new HashMap<>());
				}

				articleReply.getExtra().put("writerAvatarImgUrl",
						"/meet/file/showImg?id=" + file.getId() + "&updateDate=" + file.getUpdateDate());
			} else {
				articleReply.getExtra().put("writerAvatarImgUrl", "https://scontent-cph2-1.cdninstagram.com/v/t51.2885-19/44884218_345707102882519_2446069589734326272_n.jpg?_nc_ht=scontent-cph2-1.cdninstagram.com&_nc_ohc=7xEzH-b7neEAX8-u4aK&oh=03aa0383a46332fd1b76eaa62a308799&oe=5F72988F&ig_cache_key=YW5vbnltb3VzX3Byb2ZpbGVfcGlj.2");
			}

			Map<String, File> filesMap = new HashMap<>();

			for (File file : files) {
				filesMap.put(file.getFileNo() + "", file);
			}
		}

		Map<String, Object> rsDataBody = new HashMap<>();
		rsDataBody.put("articleReplies", articleReplies);

		return new ResultData("S-1", String.format("%s개의 댓글을 불러왔습니다.", articleReplies.size()), rsDataBody);

	}
}
