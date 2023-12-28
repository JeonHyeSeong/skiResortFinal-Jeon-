package com.web.www.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.web.www.domain.bus.BusInfoVO;
import com.web.www.domain.bus.BusVO;
import com.web.www.domain.member.AuthUser;
import com.web.www.domain.member.MemberVO;
import com.web.www.service.BusService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/bus/*")
@RequiredArgsConstructor
public class BusController {
	
	private final BusService bsv;
	
	
	@GetMapping("/busMap")
	public String busMap() {
		return "/bus/busMap";
	}
	

	@GetMapping("/busGuid")
	public String busGuid() {
		return "/bus/busGuid";
	}

	@GetMapping("/busReserve")
	public String busReserveForm(@AuthUser MemberVO mvo, Model model, BusInfoVO bivo, RedirectAttributes rttr) {
		log.info("bus mvo = {}",mvo);

		if(mvo != null) {
			if (bsv.getMemberBusCheck(mvo.getMemberNum()) > 0) {
				rttr.addFlashAttribute("isOk", 1);
				return "redirect:/member/memberQna";
			}
		}
		
		model.addAttribute("mvo", mvo);
		model.addAttribute("bivo", bivo);
		return "/bus/busReserve";
	}
	
	@PostMapping("/busReserve")
	public String busReservePost(BusVO bvo) {
		
		
		int isOk = bsv.busReserve(bvo);
		log.info("BusVO bvo = {}",bvo);
		int isBus = 0;
		log.info((isBus > 0)? "ok":"fail");
		return "index";
	}
	
	@GetMapping("/cancel")
	public String busReserveCancel(@RequestParam("busReserveNum") long busReserveNum, @AuthUser MemberVO mvo, RedirectAttributes rttr) {
		
		bsv.busCancel(busReserveNum, mvo.getMemberNum());
//		if(bvo == null) {
//			rttr.addFlashAttribute("isOk", 1);
//			return "redirect:/member/memberQna";
//		}
		
		return "redirect:/member/memberQna";
	}
	
	@PostConstruct
	public void addBusList() {
		int busCount = bsv.busCount();
		
		if(busCount == 0) {
			List<BusInfoVO> busList = new ArrayList<BusInfoVO>();
			busList.add(new BusInfoVO(1001, "강남선", 30));
			busList.add(new BusInfoVO(1002, "광화문", 30));
			busList.add(new BusInfoVO(1003, "분당선", 30));
			busList.add(new BusInfoVO(1004, "수원선", 30));
			busList.add(new BusInfoVO(1005, "잠실선", 30));
			busList.add(new BusInfoVO(1006, "천안-평택선", 30));
			for(int i = 0; i < busList.size(); i++) {
				bsv.addBusInfo(busList.get(i));
			}
		}

	}

}
