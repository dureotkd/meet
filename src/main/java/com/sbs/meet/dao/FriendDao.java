package com.sbs.meet.dao;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface FriendDao {

	void applyToFollow(int loginedMemberId, int memberId);
}
