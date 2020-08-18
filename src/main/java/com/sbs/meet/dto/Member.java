package com.sbs.meet.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Member {
	private int id;
	private int mailStatus;
	private String regDate;
	private String updateDate;
	private String nickname;
	private String loginPw;
	private String email;
	private String tier;
}
