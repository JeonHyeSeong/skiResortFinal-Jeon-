package com.web.www.service;

import java.io.IOException;
import java.util.List;

import org.springframework.http.ResponseEntity;

import com.web.www.domain.board.PagingVO;
import com.web.www.domain.pay.PayInfoVO;
import com.web.www.domain.pay.RefundInfoVO;
import com.web.www.domain.rental.RentalLiftVO;

public interface PayService {

	ResponseEntity<String> registerPay(PayInfoVO pivo) throws IOException;

	/**
	 * @param memberNum
	 * @return 특정 멤버 결제정보 조회
	 */
	List<PayInfoVO> getPayInfoList(long memberNum);

	/**
	 * @param rfiVO
	 * @return 환불 insert 이후 응답값
	 * @throws IOException
	 */
	ResponseEntity<String> payMentRefund(RefundInfoVO rfiVO, long memberNum, String memberGrade) throws IOException;

	
	//멤버의 리프트권 활성화 여부
	int getLiftBuyCheck(long memberNum);
	
	//페이징 토탈카운트
	int getTotalCount(PagingVO pgvo);

}
