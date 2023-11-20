package com.web.www.service;

import com.web.www.domain.member.MemberVO;

public interface MemberService {

	int insertMember(MemberVO mvo);
	
	
	
	
	
	
	
	
	
	/**
	 * 중복 검증 메서드 service
	 * @param memberId , memberEmail
	 * @return isOk
	 */
	int checkId(String memberId);
	int checkEmail(String memberEmail);

	

}