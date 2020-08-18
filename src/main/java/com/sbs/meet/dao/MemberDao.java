package com.sbs.meet.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.meet.dto.Member;

@Mapper
public interface MemberDao {

	int getNicknameDupCount(String nickname);

	void join(Map<String, Object> param);

	Member getMemberByEmail(String nickname);

	Member getMemberById(@Param("id") int id);
	
}
