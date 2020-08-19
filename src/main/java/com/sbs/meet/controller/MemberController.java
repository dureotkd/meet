package com.sbs.meet.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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
		Util.changeMapKey(param, "loginPwReal", "loginPw");
		ResultData checkNicknameJoinableResultData = memberService
				.checkNicknameJoinable(Util.getAsStr(param.get("nickname")));

		if (checkNicknameJoinableResultData.isFail()) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", checkNicknameJoinableResultData.getMsg());
			return "common/redirect";
		}

		int newMemberId = memberService.join(param);

		String redirectUri = (String) param.get("redirectUri");
		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	@RequestMapping("/member/login")
	public String login() {
		return "member/login";
	}

	@RequestMapping("/member/doLogin")
	public String doLogin(String email, String loginPwReal, String redirectUri, Model model, HttpSession session) {

		String loginPw = loginPwReal;
		Member member = memberService.getMemberByEmail(email);

		if (member == null) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "존재하지 않는 계정입니다.");
			return "common/redirect";
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}

		session.setAttribute("loginedMemberId", member.getId());

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "home/main";
		}

		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("%s님 환영합니다.", member.getNickname()));

		return "common/redirect";
	}

	@RequestMapping("/member/doLogout")
	public String doLogout(HttpSession session, Model model, String redirectUri) {
		session.removeAttribute("loginedMemberId");

		if (redirectUri == null || redirectUri.length() == 0) {
			redirectUri = "../home/main";
		}

		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	@RequestMapping("/member/myInfo")
	public String showMyInfo() {
		return "member/myInfo";
	}

	// 비밀번호 수정전 비번확인 form

	@RequestMapping("/member/passwordForPrivate")
	public String lockPasswordForPrivate() {
		return "member/passwordForPrivate";
	}

	// 비밀번호 수정전 비번 확인실행 form 전달

	@RequestMapping("/member/unlockPasswordForPrivate")
	public String unlockPasswordForPrivate(@RequestParam Map<String, Object> param, String loginPwReal, Model model,
			String redirectUri, HttpServletRequest req) {
//		String loginPw = (String) param.get("loginPwReal");
//		
//		
//		Member loginedMember = (Member)req.getAttribute("loginedMember");
//		
//		int loginedMemberId = loginedMember.getId();
//		// 문제
//		if (loginedMember.getLoginPw().equals(loginPw)) {
//			String authCode = memberService.getModifyPrivateAuthCode(loginedMemberId);	
//			return 	redirectUri = "modifyPrivate?authCode=" + authCode + "";
//		}
//		
//		model.addAttribute("historyBack",true);
//		model.addAttribute("alertMsg",String.format("%s님 비밀번호를 다시 확인해주세요.",loginedMember.getNickname()));
//		
//		return "common/redirect";

		String loginPw = loginPwReal;		
		Member loginedMember = (Member)req.getAttribute("loginedMember");
		
		
		// 유니크를 꼭 걸어줘야함 안그러면 충돌남.. 유니크 걸어줄 시 -> 새로운 데이터가 들어가는게 아니고 업데이트가 댐 !..

		
		if (loginedMember.getLoginPw().equals(loginPw) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", "비밀번호가 일치하지 않습니다.");
			return "common/redirect";
		}
		
		int loginedMemberId = loginedMember.getId();
		String authCode = memberService.getModifyPrivateAuthCode(loginedMemberId);	
		redirectUri = "modifyPrivate?authCode=" + authCode + "";		
		

		model.addAttribute("redirectUri", redirectUri);

		return "common/redirect";
	}

	// 본격적인 비밀번호 수정 시작
	@RequestMapping("/member/modifyPrivate")
	public String modifyPrivate() {
		return "member/modifyPrivate";
	}

	// 비밀번호 수정 실행 form 전달
	@RequestMapping("/member/doModifyPrivate")
	public String doModifyPrivate(@RequestParam Map<String, Object> param,HttpServletRequest req,String loginPwReal,String redirectUri, Model model) {
		String loginPw = loginPwReal;	
		
		Member loginedMember = (Member)req.getAttribute("loginedMember");
		int loginedMemberId = loginedMember.getId();
		
		String authCode = (String) param.get("authCode");

		if (memberService.isValidModifyPrivateAuthCode(loginedMemberId, authCode) == false) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", String.format("비밀번호를 다시 체크해주세요"));
			return "common/redirect";
		}

		// 비번 수정
		memberService.doModifyPrivate(loginedMemberId,loginPw);

		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("비밀번호가 수정되었습니다."));

		return "common/redirect";
	}

	@RequestMapping("/member/findLoginId")
	public String findLoginId() {
		return "member/findLoginId";
	}
	
	@RequestMapping("/member/doFindLoginId")
	public String doFindLoginId(String nickname,String name,Model model,String redirectUri) {
		
		Member member = memberService.doFindLoginId(nickname,name);
		
		model.addAttribute("redirectUri", redirectUri);
		model.addAttribute("alertMsg", String.format("이메일은 %s입니다",member.getEmail()));
		
		if ( member == null ) {
			model.addAttribute("historyBack", true);
			model.addAttribute("alertMsg", String.format("꺼저"));
			return "common/redirect";
		}
		
		return "common/redirect";
	}

}
