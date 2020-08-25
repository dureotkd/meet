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
import com.sbs.meet.dto.Message;
import com.sbs.meet.dto.ResultData;
import com.sbs.meet.service.FileService;
import com.sbs.meet.service.MessageService;
import com.sbs.meet.service.ReplyService;

@Controller
public class MessageControrller {
	@Autowired
	private MessageService messageService;
	
	@RequestMapping("/message/list")
	public String showList() {
		return "message/list";
	}
	
	
	@RequestMapping("/reply/doWriteMessageAjax")
	@ResponseBody
	public void doWriteReplyAjax(@RequestParam Map<String, Object> param, HttpServletRequest req,int toId) {
		Map<String, Object> rsDataBody = new HashMap<>();
		param.put("fromId", req.getAttribute("loginedMemberId"));
		param.put("toId",req.getAttribute("toId"));
		messageService.writeMessage(param);
	}

	@RequestMapping("/reply/getForPrintMessagesAjax")
	@ResponseBody
	public ResultData getForPrintRepliesAjax(@RequestParam Map<String, Object> param) {

		List<Message> messages = messageService.getForPrintMessagesAjax(param);
		
		Map<String, Object> rsDataBody = new HashMap<>();
		rsDataBody.put("messages", messages);

		return new ResultData("S-1", String.format("%s개의 메세지를 불러왔습니다.", messages.size()), rsDataBody);

	}
}
