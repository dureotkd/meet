package com.sbs.meet.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.meet.dto.Member;
import com.sbs.meet.service.FriendService;
import com.sbs.meet.service.MemberService;

@Controller
public class FriendController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private FriendService friendService;
	
	@RequestMapping("/member/follow")
	@ResponseBody
	public String showOther(@RequestParam Map<String, Object> param,Model model,int memberId,int loginedMemberId,String redirectUri) {
		
		// 팔로우 기능
		friendService.applyToFollow(loginedMemberId,memberId);
		
		
		return "common/redirect";
	}
}
