package com.sbs.meet.dao;

import java.sql.Date;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.meet.dto.File;
import com.sbs.meet.dto.Member;

@Mapper
public interface MemberDao {

	int getNicknameDupCount(String nickname);

	void join(Map<String, Object> param);

	Member getMemberByEmail(String email);

	Member getMemberById(@Param("id") int id);

	void doModifyPrivate(int id,String loginPw);

	Member doFindLoginId(String nickname, String name);

	int getEmailDupCount(String email);

	Member getMemberByEmailForFindLoginPw(String email);

	void doUpdateTempLoginPw(String loginPw,String email);

	void doMyInfoEdit(Map<String, Object> param);

	void doMyInfoEdit(String email, String name, String nickname, String introduce, int id);

	int getArticleCount(int memberId);

	void actionUpdetaSessionKey(String sessionId, Date sessionLimit, String email);

	Member checkUseWithSessionKey(String sessionId);

	void applyToFollow(int memberId, int loginedMemberId);

	File getUserAvatarImg(int memberId);

	
}
