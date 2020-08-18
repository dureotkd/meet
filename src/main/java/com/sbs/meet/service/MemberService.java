package com.sbs.meet.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.meet.dao.MemberDao;
import com.sbs.meet.dto.Member;
import com.sbs.meet.dto.ResultData;
import com.sbs.meet.util.Util;

@Service
public class MemberService {
	@Autowired
	MemberDao memberDao;

	public ResultData checkNicknameJoinable(String nickname) {
		int count = memberDao.getNicknameDupCount(nickname);
		
		if ( count == 0) {
			return new ResultData("S-1","가입가능한 소환사명 입니다.","nickname",nickname);
		}
		
		return new ResultData("F-1","이미 사용중인 소환사명 입니다.","nickname",nickname);
	}

	public int join(Map<String, Object> param) {
		memberDao.join(param);
		
		
		return Util.getAsInt(param.get("id"));
	}

	public Member getMemberByNickname(String nickname) {
		return memberDao.getMemberByNickname(nickname);
	}
}
