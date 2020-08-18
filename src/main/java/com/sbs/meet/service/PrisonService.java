package com.sbs.meet.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.meet.dao.PrisonDao;
import com.sbs.meet.dto.Prison;
import com.sbs.meet.util.Util;

@Service
public class PrisonService {
	@Autowired
	PrisonDao prisonDao;

	public int register(Map<String, Object> param) {
	prisonDao.register(param);
	int id = Util.getAsInt(param.get("id"));
	
		return id;
	}

	public Prison getForPrintPrison(String searchKeyword) {
		return prisonDao.getForPrintPrison(searchKeyword);
	}
	
	
	
}
