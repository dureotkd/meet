package com.sbs.meet.service;

import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.sbs.meet.dao.MemberDao;
import com.sbs.meet.dto.Member;
import com.sbs.meet.dto.ResultData;
import com.sbs.meet.util.Util;

@Service
public class MemberService {
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private MailService mailService;
	@Autowired
	private AttrService attrService;
	@Value("${custom.siteName}")
	private String siteName;
	
 public ResultData checkNicknameJoinable(String nickname) {
		int count = memberDao.getNicknameDupCount(nickname);
		
		if ( count == 0) {
			return new ResultData("S-1","가입가능한 닉네임 입니다.","nickname",nickname);
		}
		
		return new ResultData("F-1","이미 사용중인 닉네임 입니다.","nickname",nickname);
	}

	public int join(Map<String, Object> param) {
		memberDao.join(param);
		
		sendJoinCompleteMail((String) param.get("email"));

		
		
		return Util.getAsInt(param.get("id"));
	}

	private void sendJoinCompleteMail(String email) {
		String mailTitle = String.format("[%s] 가입이 완료되었습니다.",siteName);
		
		StringBuilder mailBodySb = new StringBuilder();
		mailBodySb.append("<h1>가입이 완료되었습니다.</h1>");
		
		
		mailService.send(email, mailTitle, mailBodySb.toString());
	}

	public Member getMemberByEmail(String email) {
		return memberDao.getMemberByEmail(email);
	}

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

	public String getModifyPrivateAuthCode(int loginedMemberId) {
		String authCode = UUID.randomUUID().toString();
		attrService.setValue("member__" + loginedMemberId + "__extra__modifyPrivateAuthCode", authCode);
		return authCode;
	}

	public boolean isValidModifyPrivateAuthCode(int loginedMemberId, String authCode) {
		String authCodeOnDB = attrService.getValue("member__" + loginedMemberId + "__extra__modifyPrivateAuthCode");
		
		return authCodeOnDB.equals(authCode);
	}

	public void doModifyPrivate(int loginedMemberId,String loginPw) {
		 memberDao.doModifyPrivate(loginedMemberId,loginPw);
	}

	public Member doFindLoginId(String nickname, String name) {
		return memberDao.doFinrIdLoginId(nickname,name);
	}
}
