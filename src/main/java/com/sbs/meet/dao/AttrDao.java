package com.sbs.meet.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface AttrDao {
	int setValue(String relTypeCode, int relId, String typeCode, String type2Code, String value);

	String getValue(@Param("relTypeCode") String relTypeCode, @Param("relId") int relId,
			@Param("typeCode") String typeCode, @Param("type2Code") String type2Code);

	void remove(String relTypeCode, int relId, String typeCode, String type2Code);
}
