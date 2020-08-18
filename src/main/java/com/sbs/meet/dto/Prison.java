package com.sbs.meet.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Prison {
	private int id;
	private int memberId;
	private String regDate;
	private String updateDate;
	private String nickname;
	private String tier;
}
