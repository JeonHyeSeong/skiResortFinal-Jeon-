package com.web.www.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.web.www.domain.board.NoticeVO;
import com.web.www.domain.board.PagingVO;
import com.web.www.domain.coupon.CouponCreate;
import com.web.www.domain.coupon.CouponSpread;
import com.web.www.domain.coupon.CouponSystem;
import com.web.www.domain.hotel.RoomVO;
import com.web.www.domain.member.AuthUser;
import com.web.www.domain.member.MemberVO;
import com.web.www.handler.PagingHandler;
import com.web.www.repository.AdminDAO;
import com.web.www.service.AdminService;
import com.web.www.service.HotelService;
import com.web.www.service.NoticeService;
import com.web.www.service.QnaService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/developer/*")
@RequiredArgsConstructor
public class AdminController {

	private final AdminService asv;
	private final HotelService hsv;
	private final AdminDAO adao;
	private final QnaService qsv;
	private final NoticeService nsv;
	
	@GetMapping("/settingMain")
	public String adminPageForm() {
		return "/developer/settingMain";
	}
	
	
	
	/*************************************
	 * @Developer 관리자 페이지 "멤버 관리"
	 *************************************/
	
	@GetMapping("/settingMember")
	public String memberListForm(Model model) {
		List<MemberVO> mvoList =  asv.getMemberList();
		
		for (MemberVO mvo : mvoList) {
			mvo.setAuthList(adao.selectAuths(mvo.getMemberId()));
		}
		
		model.addAttribute("mvoList", mvoList);
		return "/developer/settingMember";
	}
	
	@GetMapping("/authUp/{id}")
	public int authMemberUp(@PathVariable("id")String MemberId) {
		int isOk = asv.authUp(MemberId);
		return isOk;
	}
	
	@GetMapping("/authDown/{id}")
	public int authMemberDown(@PathVariable("id")String MemberId) {
		int isOk = asv.authDown(MemberId);
		return isOk;
	}
	
	@GetMapping("/settingCoupon")
	public String couponListForm(Model model) {
		List<CouponSystem> csList = asv.getCouponList();
		model.addAttribute("csList", csList);
		return "/developer/settingCoupon";
	}
	
	@PostMapping("/createCoupon")
	public String couponCreate(@Validated @ModelAttribute("cpc") CouponCreate cpc, 
			BindingResult bindingResult, RedirectAttributes rttr) {
		
		if(bindingResult.hasErrors()) {
			rttr.addFlashAttribute("isOk", 3);
			return "redirect:/developer/settingCoupon";
		}
		
		
		int isOk = asv.couponCreate(cpc);
		rttr.addFlashAttribute("isOk", isOk);
		return "redirect:/developer/settingCoupon";
	}
	
	@PostMapping("/deleteCoupon")
	public String couponRemove(@RequestParam("couponCode") String couponCode, RedirectAttributes rttr) {
		if(couponCode == null) {
			rttr.addFlashAttribute("isDel;", 3);
			return "redirect:/developer/settingCoupon";
		}
		
		int isDel = asv.couponRemove(couponCode);
		log.info("isDel ######## = {}",isDel);
		rttr.addFlashAttribute("isDel", isDel);
		return "redirect:/developer/settingCoupon";
	}
	
	@PostMapping("/spreadCoupon")
	public String spreadCoupon(@RequestParam("memberId") String memberId, 
			@RequestParam("couponCode")String couponCode, RedirectAttributes rttr) {
		if(couponCode == null || memberId == null) {
			rttr.addFlashAttribute("isOk;", 3);
			return "redirect:/developer/settingCoupon";
		}
		
		int isOk = asv.spreadCoupon(memberId, couponCode);
		rttr.addFlashAttribute("isOk", isOk);
		return "redirect:/developer/settingCoupon";
	}
	
	
	@PostMapping("/allSpreadCoupon")
	public String allSpreadCoupon(@Validated @ModelAttribute("cps")CouponSpread cps,BindingResult bindingResult , RedirectAttributes rttr) {
		
		if(bindingResult.hasErrors()) {
			rttr.addFlashAttribute("isOk", 3);
			return "redirect:/developer/settingCoupon";
		}
		
		int isOk = asv.allSpreadCoupon(cps);
		rttr.addFlashAttribute("isOk", isOk);
		return "redirect:/developer/settingCoupon";
	}
	
	/*************************************
	 * @Developer 관리자 페이지 "호텔 관리"
	 *************************************/
	
	@GetMapping("/settingHotel")
	public String hotelListForm(Model m ,@AuthUser MemberVO mvo) {
		List<RoomVO> roomList = hsv.getRoomList();
		m.addAttribute("roomList", roomList);
		m.addAttribute("mvo", mvo);
		return "/developer/settingHotel";
	}
	
	@PostMapping("/addRoom")
	public String addRoom(RoomVO rvo) {
		int isOk = hsv.addRoom(rvo);
		return "redirect:/developer/settingHotel";
	}
	@GetMapping("deleteRoom")
	public String deleteRoom(@RequestParam("hotelRoomNum") int hotelRoomNum, RedirectAttributes reatt) {
		log.info(hotelRoomNum + "<<<<<hotelRoomNum");
		int isOk = hsv.deleteRoom(hotelRoomNum);
		reatt.addFlashAttribute("susdel", isOk > 0 ? "y" : "n");
		return "redirect:/developer/settingHotel";
	}
	@PostMapping("modifyRoom")
	public String modifyRoom(RoomVO rvo, RedirectAttributes reatt) {
		log.info(rvo + ">>>rvo");
		int isOk = hsv.modifyRoom(rvo);
		reatt.addFlashAttribute("susmodi", isOk > 0 ? "y" : "n");
		return "redirect:/developer/settingHotel";
	}
	
	
	
	/*************************************
	 * @Developer 관리자 페이지 "렌탈/리프트 관리"
	 *************************************/
	
	@GetMapping("/settingRental")
	public String RentalList(Model m ,@AuthUser MemberVO mvo) {
		return "/developer/settingRental";
	}
	
	
	
	
	
	/*************************************
	 * @Developer 관리자 페이지 "게시판 관리"
	 *************************************/
	
	//notice 코드 라인//
	@GetMapping("/settingNotice")
	public void noticeList(Model m, PagingVO pgvo) {
		m.addAttribute("list", nsv.noticeList(pgvo)); //페이징처리 리스트
		m.addAttribute("NoPagingList", nsv.noticeListNoPaging()); //페이징처리x 리스트
		m.addAttribute("plist", nsv.noticePointList(pgvo)); //중요공지 목록 가져오기
		int totalCount = nsv.getTotalCount(pgvo);
		PagingHandler ph = new PagingHandler(pgvo, totalCount);
		m.addAttribute("ph",ph);
	}
	
	@PostMapping("/settingNoticeModify")
	public String noticePointModify(Model m, NoticeVO nvo) {
		log.info(">>>>>setting nvo >> "+nvo);
		int isOk = nsv.settingNoticePointModify(nvo);
		log.info(">>>>>setting notice point modify >> "+(isOk > 0? "OK" : "Fail"));
		m.addAttribute("isOk", isOk);
		return "redirect:/developer/settingNotice";
	}
	
	@GetMapping("/noticeRemove")
	public String noticeRemove(@RequestParam("noticeNum")long noticeNum, RedirectAttributes re) {
		int isOk2 = nsv.noticeRemove(noticeNum);
		log.info(">>>>> notice remove >> "+(isOk2 > 0? "OK" : "Fail"));
		re.addFlashAttribute("isOk2", isOk2);
		return "redirect:/developer/settingNotice";
	}
	

	
	//Q&A 코드 라인//
	@GetMapping("/settingQna")
	public void QnaList(HttpSession ses, Model m, PagingVO pgvo) {
		m.addAttribute("list", qsv.qnaList(pgvo)); //페이징처리 리스트
		m.addAttribute("NoPagingList", qsv.qnaListNoPaging()); //페이징처리x 리스트
		int totalCount = qsv.getTotalCount(pgvo);
		PagingHandler ph = new PagingHandler(pgvo, totalCount);
		m.addAttribute("ph",ph);
	}

	
	@GetMapping("/qnaRemove")
	public String qnaRemove(@RequestParam("qnaNum")long qnaNum, RedirectAttributes re) {
		int isOk = qsv.qnaRemove(qnaNum);
		log.info(">>>>> qna remove >> "+(isOk > 0? "OK" : "Fail"));
		re.addFlashAttribute("isOk", isOk);
		return "redirect:/developer/settingQna";
	}
	
	@GetMapping("/settingQnaMember")
	public String qnaMember() {
		return "/developer/settingQnaMember";
	}
	
	
	
	
	
}
