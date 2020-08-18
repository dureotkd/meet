package com.sbs.meet.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.sbs.meet.dto.Prison;

@Mapper
public interface PrisonDao {

	void register(Map<String, Object> param);

	Prison getForPrintPrison(String searchKeyword);
	
}
