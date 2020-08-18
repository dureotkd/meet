package com.sbs.meet.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.meet.dto.Member;
import com.sbs.meet.dto.ResultData;
import com.sbs.meet.service.MemberService;
import com.sbs.meet.util.Util;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/member/join")
	public String join() {
		return "member/join";
	}
	
	@RequestMapping("/member/doJoin")
	public String doJoin(@RequestParam Map<String, Object> param, Model model) {
		Util.changeMapKey(param,"loginPwReal", "loginPw");
		ResultData checkNicknameJoinableResultData = memberService.checkNicknameJoinable(Util.getAsStr(param.get("nickname")));
		
		if (checkNicknameJoinableResultData.isFail()) {
			model.addAttribute("historyBack",true);
			model.addAttribute("alertMsg",checkNicknameJoinableResultData.getMsg());
			return "common/redirect";
		}
		
		int newMemberId = memberService.join(param);
		
		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri",redirectUri);
		
		return "common/redirect";
	}
	
	@RequestMapping("/member/login")
	public String login() {
		return "member/login";
	}
	
	@RequestMapping("/member/doLogin")
	public String doLogin(String email, String loginPwReal, String redirectUri , Model model, HttpSession session) {
		
		String loginPw = loginPwReal;
		Member member = memberService.getMemberByEmail(email);
		
		if (member == null) {
			model.addAttribute("historyBack",true);
			model.addAttribute("alertMsg","존재하지 않는 계정입니다.");
			return "common/redirect";
		}
		
		if (member.getLoginPw().equals(loginPw) == false ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg","비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}
		
		session.setAttribute("loginedMemberId",member.getId());
		
		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "home/main";
		}
		
		model.addAttribute("redirectUri",redirectUri);
		model.addAttribute("alertMsg",String.format("%s님 환영합니다.",member.getNickname()));
		
		return "common/redirect";
	}
	
	@RequestMapping("/member/doLogout")
	public String doLogout(HttpSession session, Model model, String redirectUri) {
		session.removeAttribute("loginedMemberId");
		
		if ( redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "../home/main";
		}
		
		model.addAttribute("redirectUri",redirectUri);
		
		return "common/redirect";
	}
	
	
}
