package com.web.www.repository;

import java.util.List;

import com.web.www.domain.board.PagingVO;
import com.web.www.domain.pay.PayInfoVO;
import com.web.www.domain.pay.RefundInfoVO;

public interface PayDAO {

	/**
	 * 멤버 결제정보 등록
	 * @param upiDTO
	 */
	void registerPay(PayInfoVO upiDTO);

	/**
	 * @param memberNum
	 * @return 멤버정보 조회
	 */
	List<PayInfoVO> getPayInfoList(long memberNum);

	
	/**
	 * 환불테이블 작성 mapper id 입니다.
	 * @param rfiVO
	 * @param payImpUid
	 */
	void registerRefund(RefundInfoVO rfiVO);
	int payMentRefund(String payImpUid);

	/**
	 * @param payMerchantUid
	 * @return 취소된 내역인지 확인합니다(갯수 리턴 1=true 0=false)
	 */
	int payStatusCheck(String payMerchantUid);

	
	
	/**
	 * 호텔 객실관련
	 * @param payMerchantUid
	 * @return
	 */
	int refundRoomInfo(String payMerchantUid);

	
	/**
	 * 날짜 마감일 확인
	 * @param payMerchantUid
	 * @return
	 */
	int checkRoomDay(String payMerchantUid);
	int checkLiftDay(String payMerchantUid);
//	int checkRantalDay(String payMerchantUid);

	
	//결제금액 합산후 등급 갱신
	long memberAmountSum(long memberNum);

	//리프트권 구매여부 체크
	int getLiftBuyCheck(long memberNum);
	
	//페이징 토탈 카운트
	int getTotalCount(PagingVO pgvo);

	



	

}
