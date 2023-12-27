package com.web.www.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.web.www.domain.board.PagingVO;
import com.web.www.domain.member.AuthUser;
import com.web.www.domain.member.MemberVO;
import com.web.www.domain.pay.PayInfoVO;
import com.web.www.domain.pay.PayResponseDTO;
import com.web.www.domain.pay.RefundInfoVO;
import com.web.www.handler.PagingHandler;
import com.web.www.service.MemberService;
import com.web.www.service.PayService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/pay/*")
@Controller
@RequiredArgsConstructor
public class PayController {
	
	private final PayService psv;
	private final MemberService msv;
	
	//유저 결제 상세 페이지
	@GetMapping("/memberPayList")
	public String memberPayList(PagingVO pgvo, @AuthUser MemberVO mvo, Model model) {
		MemberVO detailMvo = msv.getUser(mvo.getMemberId() , mvo.getMemberType());
		List<PayInfoVO> pivoList = psv.getPayInfoList(mvo.getMemberNum());
		log.info("결제정보 조회 = {}", pivoList);
		long sum = 0;
		for (PayInfoVO payInfo : pivoList) {
			if(payInfo.getPayStatus().equals("결제완료")) {
				sum += payInfo.getPayAmount();
			}
		}
		model.addAttribute("sum", sum);
		model.addAttribute("mvo", detailMvo);
		model.addAttribute("pivoList" , pivoList);
		//페이징 라인
		int totalCount = psv.getTotalCount(pgvo);
		PagingHandler ph = new PagingHandler(pgvo, totalCount);
		log.info(">>>>ph>>>"+ ph);
		model.addAttribute("ph",ph);
		return "/member/memberPayList";
	}
	
	
	@ResponseBody
	@PostMapping(value = "/portOne", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE+ ";charset=UTF-8")
	public ResponseEntity<String> portOnePay(@RequestBody PayInfoVO pivo, @AuthUser MemberVO mvo) throws IOException {
		log.info(pivo+"pivopivopivopivo");
		if(mvo == null) {
			return new ResponseEntity<String>("회원 정보가 없습니다.",HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		try {
	        pivo.setMemberNum(mvo.getMemberNum());
	        pivo.setMemberGrade(mvo.getMemberGrade());
	        log.info("##결제 정보##  = {}" , pivo);
	        //결제정보 테이블 저장
	        return psv.registerPay(pivo);
	    } catch (Exception e) {
	        log.error("결제 처리 중 오류 발생", e);
	        return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	@ResponseBody
	@PostMapping(value = "/refund", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.TEXT_PLAIN_VALUE+ ";charset=UTF-8")
	public ResponseEntity<String> refund(@RequestBody RefundInfoVO rfiVO, @AuthUser MemberVO mvo) throws IOException {
		
		log.info("##환불정보## = {}", rfiVO);
		ResponseEntity<String> isOk = psv.payMentRefund(rfiVO, mvo.getMemberNum(), mvo.getMemberGrade());
		return isOk;
	}
	
	//결제 성공시 안내 페이지
	@GetMapping("/PaySuccess")
	public String SuccessForm(PayResponseDTO prDTO, Model model) {
		log.info("prDTO####### = {}", prDTO);
		model.addAttribute("prDTO", prDTO);
		return "/pay/PaySuccess";
	}
	
	//결제 실패시 안내 페이지
	@GetMapping("/PayFail")
	public String FailForm(@RequestParam String errorMessage, Model model) {
		log.info("errorMessage####### = {}", errorMessage);
		model.addAttribute("errorMessage", errorMessage);
		return "/pay/PayFail";
	}

}
