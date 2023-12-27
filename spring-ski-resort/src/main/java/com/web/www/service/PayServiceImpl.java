package com.web.www.service;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.web.www.domain.alarm.AlarmVO;
import com.web.www.domain.board.PagingVO;
import com.web.www.domain.pay.PayInfoVO;
import com.web.www.domain.pay.RefundInfoVO;
import com.web.www.domain.rental.ItemsArray;
import com.web.www.repository.AlarmDAO;
import com.web.www.repository.MemberDAO;
import com.web.www.repository.PayDAO;
import com.web.www.repository.RentalDAO;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@PropertySource("classpath:outApiProperties.properties")
@RequiredArgsConstructor
public class PayServiceImpl implements PayService{
	
	private final PayDAO pdao;
	private final AlarmDAO adao;
	private final HotelService hsv;
	private final MemberDAO mdao;
	private final RentalDAO rdao;
	
	@Value("${pay.imp}")
	private String imp_uid;
	
	@Value("${pay.key}")
	private String imp_key;
	
	@Value("${pay.secret}")
	private String imp_secret;
	
	@ToString
	@Getter
	private class Response{
		private PaymentInfo response;
	}
	
	@ToString
	@Getter
	private class PaymentInfo{
		private long amount;
	}
	
	/***************************************************************************************************/
	/***************************************************************************************************/
	/**************************************  비  즈  니  스  로  직  ***************************************/
	/***************************************************************************************************/
	/***************************************************************************************************/
	
	/**
	 * @return 
	 * @throws IOException 
	 * @Method 결제정보 DB저장
	 */
	@Transactional
	@Override
	public ResponseEntity<String> registerPay(PayInfoVO pivo) throws IOException {
		
		// 1. 아임포트 API 키와 SECRET키로 토큰을 생성
			String access_token = getToken();
			log.info("아임포트 엑세스 토큰값 확인 = {}", access_token);
	    
		// 2. 토큰으로 결제 완료된 주문정보를 가져옴
			//amount는 결제완료된 금액입니다.
			long amount = paymentInfo(pivo.getPayImpUid(), access_token);
			
			
			
		/*********** 내부 비즈니스 로직 영역 *********/

		switch (pivo.getPayNameType()) {
		
			case "호텔":
				//[호텔]방이없을때 return
				int cheakRoomCount = hsv.cheakRoomCount(pivo.getUniqueNumber());
				if (cheakRoomCount <= 0) {
					
					adao.alarmSetting(new AlarmVO(pivo.getMemberNum(), 4, "취소"));// 시스템 알람 반드시 넣어주세요.
					payMentCancel(access_token, pivo.getPayImpUid(), amount, "이용 가능한 방이 없습니다.");
					return new ResponseEntity<String>("이용 가능한 방이 없습니다.", HttpStatus.BAD_REQUEST);
				}
				//[호텔] 추가 로직
				
				
				
				break;
			case "렌탈":
				//[렌탈]장비가 없을때 return
				
				/*
				 *  구매한 물건의 넘버, 개수가 그대로 넘어와서
				 * 전부 검증을 해야합니다.
				 * ex) 3개가 남았을때 구매하고싶은게 4개라면 -1로 되니까 이런걸 쳐내야함.
				 * 
				 * 로직순서
				 * 1. 상품 고유번호를 얻고, 고유번호별 개수를 구한다(스트림 사용)
				 * 2. 고유 번호로 상품을 조회한다. 그리고 상품 개수와 고유번호별 개수를 비교한다.
				 * 3. 상품개수가 적으면 itemLack.add하면 끝
				 * */
				
				//구매하려는 상품들 고유번호 얻기
				List<Long> rentalItemNum = new ArrayList<>();
				for (ItemsArray arr : pivo.getRentalItems()) {
					rentalItemNum.add(arr.getRentalItemNum());
				}
				// 장바구니 고유번호별 물건 개수
				Map<Long, Long> basketAmount = rentalItemNum.stream()
						.collect(Collectors.groupingBy(e -> e, Collectors.counting()));
				// 상품 고유번호별 물건 개수
				List<Long> distinctRentalItemNums = rentalItemNum.stream()
			                .distinct()
			                .collect(Collectors.toList());
				
				// 장바구니 vs 상품 개수 비교 로직
				Map<Long, Integer> rentalItemAmount = new HashMap<>();
				for (Long rentalItemNum2 : distinctRentalItemNums) {
				    Map<Long, Object> rawResult = rdao.getRentaiItemAmount(rentalItemNum2);

				    // rawResult에서 값을 얻어와서 Map<Long, Integer>로 변환
				    Long key = (Long) rawResult.get("rental_list_item_num");
				    Object value = rawResult.get("rental_list_item_count");

				    // value가 Integer 타입이라면 변환하여 담기
				    if (value instanceof Integer) {
				        rentalItemAmount.put(key, (Integer) value);
				    }
				}
				
				int itemCnt = 0;
				List<String> itemLack = new ArrayList<>();
				
				for (Long key : distinctRentalItemNums) {
				    if (rentalItemAmount.containsKey(key) && basketAmount.containsKey(key)) {
				        int rentalItemValue = rentalItemAmount.get(key);
				        long basketAmountValue = basketAmount.get(key);
				        
				        // rentalItemAmount의 값이 작다면 처리 추가
				        if (rentalItemValue < basketAmountValue) {
				        	for (ItemsArray item : pivo.getRentalItems()) {
				        		if(item.getRentalItemNum() == key) {
				        			String temp = item.getRentalItemName();
				        			itemLack.add(temp);
				        		}
							}
				        	itemCnt++;
				        }
				    }
				}

				if(itemCnt > 0) {
					List<String> distinctItemLack = itemLack.stream()
							.distinct()
			                .collect(Collectors.toList());
					
					adao.alarmSetting(new AlarmVO(pivo.getMemberNum(), 4, "취소"));// 시스템 알람 반드시 넣어주세요.
					payMentCancel(access_token, pivo.getPayImpUid(), amount, "렌탈 장비 품절");

					String resultStr = "";
					for (String str : distinctItemLack) {
						resultStr +=  str + "<br>";
					}
					resultStr = resultStr.replaceAll("<br>$", "");
					return new ResponseEntity<String>("상품 품절 상태입니다. <br><span style=\"font-size:16px;\">" + resultStr + "</span>", HttpStatus.BAD_REQUEST);

				}

				//[렌탈] 추가 로직
				
				break;
			case "리프트":
				
				//[리프트] 리프트권을 이미 구매했으면 return
				if(pdao.getLiftBuyCheck(pivo.getMemberNum()) > 0) {
					payMentCancel(access_token, pivo.getPayImpUid(), amount, "현재 이용중인 리프트권이 있습니다.");
					return new ResponseEntity<String>("현재 이용중인 리프트권이 있습니다.", HttpStatus.BAD_REQUEST);
				}
				
				break;
	
			default:
				
				break;
		}

		/*********************************/
		
		/*성공시*/
		if(!(pivo.getCouponCode().isEmpty())) {
			mdao.useCoupon(pivo.getMemberNum(),pivo.getCouponCode());	//쿠폰 사용 처리
		}
		pdao.registerPay(pivo);
		
		/**
		 * @amountSum 회원의 결제금액 합산
		 * 결제금액으로 등급을 조정하는 로직입니다.
		 */
		memberGradeUpdate(pivo.getMemberNum());
		if(!(pivo.getMemberGrade().equals(mdao.getMemberGrade(pivo.getMemberNum())))) {
			adao.alarmSetting(new AlarmVO(pivo.getMemberNum(), 6, "등급"));
		}
		
		adao.alarmSetting(new AlarmVO(pivo.getMemberNum(), 2, "결제"));// 시스템 알람 반드시 넣어주세요.
		return new ResponseEntity<String>("결제완료", HttpStatus.OK);
		
	}



	/**
	 * @throws IOException 
	 * @Method 환불
	 */
	@Transactional
	@Override
	public ResponseEntity<String> payMentRefund(RefundInfoVO rfiVO, long memberNum, String memberGrade) throws IOException {
		
		/********** 환불 비즈니스 로직 **************/
		
		//[공통] 이미 취소된 내역이면 return
		if(pdao.payStatusCheck(rfiVO.getPayMerchantUid()) != 0) {
			return new ResponseEntity<String>("이미 취소된 내역입니다.", HttpStatus.BAD_REQUEST);
		}
		
		//[공통] 상품 환불가능기간 하루전 기간이 지났으면 return

		
		switch (rfiVO.getRefundNameType()) {
		case "호텔":
			//[호텔] 상품 환불가능기간 하루전 기간이 지났으면 return
			if(pdao.checkRoomDay(rfiVO.getPayMerchantUid()) == 0) {
			    return new ResponseEntity<String>("환불가능한 날짜가 지났습니다.", HttpStatus.BAD_REQUEST); 
			}
			
			//[호텔] 환불시 room_info 테이블 삭제 로직 (쿼리문이 delete라서 젤 뒤에 배치합니다.)
			if(pdao.refundRoomInfo(rfiVO.getPayMerchantUid()) == 0) {
				return new ResponseEntity<String>("환불할 거래 정보가 없습니다.", HttpStatus.BAD_REQUEST);
			}
			
			
			break;
		case "렌탈":
			//[렌탈] 환불시 아이템 개수 재충전 and 테이블 반납여부 Y로 변경
			long rentalReserveNum = rdao.itemsPayInfoPrimaryKeyGet(rfiVO.getPayMerchantUid());
			List<Long> rentalItemNumList = rdao.getRentalItemNumList(rentalReserveNum);
			for (Long itemListNum : rentalItemNumList) {
				rdao.rentalItemListPlus(itemListNum);
			}
			rdao.itemPayInfoReturnCheck(rfiVO.getPayMerchantUid());
			
			
			
			break;
		case "리프트":
			//[리프트] 상품 환불가능기간 하루전 기간이 지났으면 return
			if(pdao.checkLiftDay(rfiVO.getPayMerchantUid()) == 0) {
			    return new ResponseEntity<String>("환불가능한 날짜가 지났습니다.", HttpStatus.BAD_REQUEST); 
			}
			break;

		default:
			break;
		}

		
		/***************************************/
		
		
		// 로직 통과하면 정상 진행
		String access_token = getToken();
		
		// 카드회사에서 "결제금액" 내역 가져오기
		long amount = paymentInfo(rfiVO.getPayImpUid(), access_token);
		
		/* 환불하려는 금액과 결제정보내 금액이 같은지 확인 if문 해도될듯? */
		
		//카드회사로 환불요청 보내기
		payMentCancel(access_token, rfiVO.getPayImpUid(), amount, rfiVO.getRefundReason());
		
		
		/**
		 * @pado.registerRefund 환불된 내역 DB에 저장
		 * @pdao.payMentRefund 결제내역중 결제상태를 '결제취소' 로 변경
		 */
		pdao.registerRefund(rfiVO);
		pdao.payMentRefund(rfiVO.getPayImpUid());
		
		
		/**
		 * @amountSum 회원의 결제금액 합산
		 * 결제금액으로 등급을 조정하는 로직입니다.
		 */
		/**
		 * @amountSum 회원의 결제금액 합산
		 * 결제금액으로 등급을 조정하는 로직입니다.
		 */
		memberGradeUpdate(memberNum);
		if(!(memberGrade.equals(mdao.getMemberGrade(memberNum)))) {
			adao.alarmSetting(new AlarmVO(memberNum, 6, "등급"));
		}
	

//		adao.alarmSetting(new AlarmVO(memberNum, 6, "등급"));
		adao.alarmSetting(new AlarmVO(memberNum, 3, "환불"));// 시스템 알람 반드시 넣어주세요.
		return new ResponseEntity<String>("정상적으로 환불되었습니다.", HttpStatus.OK);
	}
	
	
	/***************************************************************************************************/
	/***************************************************************************************************/
	/***************************************************************************************************/
	/***************************************************************************************************/
	/***************************************************************************************************/
	
	
	//등급 계산 로직
	private void memberGradeUpdate(long memberNum) {
		long amountSum = pdao.memberAmountSum(memberNum);
		if(amountSum > 1000000 && amountSum < 2000000) {
			mdao.memberGradeUpdate(memberNum, "Silver");
		}else if(amountSum >= 2000000 && amountSum < 3000000) {
			mdao.memberGradeUpdate(memberNum, "Gold");
		}else if(amountSum >= 3000000) {
			mdao.memberGradeUpdate(memberNum, "VIP");
		}else {
			mdao.memberGradeUpdate(memberNum, "Bronze");
		}
	}
	
	
	
	/**
	 * @Method 회원 결제정보 리스트
	 */
	@Override
	public List<PayInfoVO> getPayInfoList(long memberNum) {
		return pdao.getPayInfoList(memberNum);
	}
	
	/**
	 * @Method 회원 리프트권 구매여부 체크
	 */
	@Override
	public int getLiftBuyCheck(long memberNum) {
		return pdao.getLiftBuyCheck(memberNum);
	}
	
	
	
	//아임포트 엑세스 토큰 가져오기
	public String getToken() throws IOException {
		
		HttpsURLConnection conn = null;
		URL url = new URL("https://api.iamport.kr/users/getToken");
		 
		conn = (HttpsURLConnection) url.openConnection();

		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setDoOutput(true);
		JsonObject json = new JsonObject();

		json.addProperty("imp_key", imp_key);
		json.addProperty("imp_secret", imp_secret);
		
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
		
		bw.write(json.toString());
		bw.flush();
		bw.close();

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));

		Gson gson = new Gson();

		String response = gson.fromJson(br.readLine(), Map.class).get("response").toString();
		
		System.out.println(response);

		String token = gson.fromJson(response, Map.class).get("access_token").toString();

		br.close();
		conn.disconnect();

		return token;
	}
	
	//결제정보 가져오기
	public long paymentInfo(String imp_uid, String access_token) throws IOException {
		
	    HttpsURLConnection conn = null;
	 
	    URL url = new URL("https://api.iamport.kr/payments/" + imp_uid);
	 
	    conn = (HttpsURLConnection) url.openConnection();
	 
	    conn.setRequestMethod("GET");
	    conn.setRequestProperty("Authorization", access_token);
	    conn.setDoOutput(true);
	 
	    BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
	    
	    Gson gson = new Gson();
	    
	    Response response = gson.fromJson(br.readLine(), Response.class);
	    
	    br.close();
	    conn.disconnect();
	    
	    return response.getResponse().getAmount();
	}
	
	//결제취소
	public void payMentCancel(String access_token, String imp_uid, long amount, String reason) throws IOException  {
		log.info("결제 취소 진입합니다.");
		log.info(access_token);
		log.info(imp_uid);
		
		HttpsURLConnection conn = null;
		URL url = new URL("https://api.iamport.kr/payments/cancel");
 
		conn = (HttpsURLConnection) url.openConnection();
 
		conn.setRequestMethod("POST");
 
		conn.setRequestProperty("Content-type", "application/json");
		conn.setRequestProperty("Accept", "application/json");
		conn.setRequestProperty("Authorization", access_token);
 
		conn.setDoOutput(true);
		
		JsonObject json = new JsonObject();
 
		json.addProperty("reason", reason);
		json.addProperty("imp_uid", imp_uid);
		json.addProperty("amount", amount);
		json.addProperty("checksum", amount);
 
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
 
		bw.write(json.toString());
		bw.flush();
		bw.close();
		
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
 
		br.close();
		conn.disconnect();
		
		
	}



	@Override
	public int getTotalCount(PagingVO pgvo) {
		// TODO Auto-generated method stub
		return pdao.getTotalCount(pgvo);
	}

	
}
