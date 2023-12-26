package com.web.www.controller;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.modelmapper.ModelMapper;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.web.www.domain.board.PagingVO;
import com.web.www.domain.member.AuthUser;
import com.web.www.domain.member.FindIdDTO;
import com.web.www.domain.member.FindPwdDTO;
import com.web.www.domain.member.MemberPwdDTO;
import com.web.www.domain.member.MemberVO;
import com.web.www.domain.member.ModifyMemberDTO;
import com.web.www.domain.member.RegisterMemberDTO;
import com.web.www.domain.pay.PayInfoVO;
import com.web.www.handler.MemberEmailHandler;
import com.web.www.handler.PagingHandler;
import com.web.www.service.BusService;
import com.web.www.service.MemberService;
import com.web.www.service.QnaService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/member/*")
@RequiredArgsConstructor
public class MemberController {

	private final MemberService msv;
	private final MemberEmailHandler mailService;
	private final QnaService qsv;
	private final BusService bsv;
	
	/**
	 * @BCryptPasswordEncoder 사용자 pwd 인코더
	 */
	private final BCryptPasswordEncoder bcEncoder;
	
	@GetMapping("/login")
	public String loginForm() {
		return "/member/login";
	}
	
	@PostMapping("/login")
	public String login(HttpServletRequest request, RedirectAttributes rttr) {
		
		if(request.getAttribute("errMsg").equals("Bad credentials")) {
			rttr.addFlashAttribute("errMsg", 1);
		}
		
		return "redirect:/member/login";
	}
	
	
	@GetMapping("/register")
	public String registerForm(Model model) {
		model.addAttribute("mvo", new RegisterMemberDTO());
		return "/member/register";
	}
	
	@PostMapping("/register")
	public String register(@Validated @ModelAttribute("mvo")RegisterMemberDTO mvoDTO, BindingResult bindingResult) {

		if(bindingResult.hasErrors()) {
			return "/member/register";
		}
		ModelMapper modelMapper = new ModelMapper();
		MemberVO mvo = modelMapper.map(mvoDTO, MemberVO.class);
		
		mvo.setMemberPwd(bcEncoder.encode(mvo.getMemberPwd()));
		int isOk = msv.insertMember(mvo);
		return "redirect:/";
	}

	@GetMapping("/detail")
	public String detailForm(@AuthUser MemberVO mvo, Model model, PayInfoVO pivo) {
		MemberVO detailMvo = msv.getUser(mvo.getMemberId() , mvo.getMemberType());
		model.addAttribute("mvo", detailMvo);
		model.addAttribute("mDTO", new RegisterMemberDTO());
		return "/member/detail";
	}
	
	@PostMapping("/detail")
	public String detail(@Validated @ModelAttribute("mDTO") ModifyMemberDTO mDTO,
			BindingResult bindingResult, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes rttr, Model model, @AuthUser MemberVO mvo) {
		
		if(bindingResult.hasErrors()) {
			model.addAttribute("mvo", mvo);
			return "/member/detail";
		}
		
		int isMod = msv.modifyMember(mDTO);
		rttr.addFlashAttribute("isMod", isMod);
		logout(request, response);
		return "redirect:/member/login";
	}
	
	@GetMapping("/memberPwd")
	public String pwdForm(@AuthUser MemberVO mvo, Model model) {
		MemberVO detailMvo = msv.getUser(mvo.getMemberId() , mvo.getMemberType());
		model.addAttribute("mvo", detailMvo);
		model.addAttribute("mpDTO", new MemberPwdDTO());
		return "/member/memberPwd";
	}
	
	@PostMapping("/memberPwd")
	public String pwdChange(@Validated @ModelAttribute("mpDTO")MemberPwdDTO mpDTO, BindingResult bindingResult, 
			HttpServletRequest request, HttpServletResponse response, @AuthUser MemberVO mvo,
			RedirectAttributes rttr, Model model) {
		
		if(bindingResult.hasErrors()) {
			MemberVO detailMvo = msv.getUser(mvo.getMemberId() , mvo.getMemberType());
			model.addAttribute("mvo", detailMvo);
			return "/member/memberPwd";
		}
			
		if(bcEncoder.matches(mpDTO.getExPwd(), mvo.getMemberPwd())) {
			
			//회원 넘버와 인코딩된 비밀번호 저장
			mpDTO.setMemberNum(mvo.getMemberNum());
			mpDTO.setChangePwd(bcEncoder.encode(mpDTO.getChangePwd()));
			
			//변경된 비밀번호 저장
			int isMod = msv.updatePwd(mpDTO);
			
			rttr.addFlashAttribute("isMod", isMod);
			logout(request, response);
			return "redirect:/member/login";
		}else {
			int isMod = 2;
			rttr.addFlashAttribute("isMod", isMod);
			return "redirect:/member/memberPwd";
		}
		
	}
	
	@PostMapping("/daisukiLeave")
	public String memberLeave(@AuthUser MemberVO mvo, @RequestParam("memberPwd")String memberPwd, 
			RedirectAttributes rttr, Model model, HttpServletRequest request, HttpServletResponse response) {
		
		if(!(bcEncoder.matches(memberPwd, mvo.getMemberPwd()))) {
			rttr.addFlashAttribute("isLeave", 1);
			return "redirect:/member/detail";
		}
		
		
		int isOk = msv.memberLeave(mvo);
		rttr.addFlashAttribute("isOk", isOk);
		logout(request, response);
		return "redirect:/member/login";
	}

	
	@PostMapping("/socialDaisukiLeave")
	public String socialMemberLeave(@AuthUser MemberVO mvo, RedirectAttributes rttr, 
			Model model, HttpServletRequest request, HttpServletResponse response) {
		
		
		int isOk = msv.memberLeave(mvo);
		rttr.addFlashAttribute("isOk", isOk);
		logout(request, response);
		return "redirect:/member/login";
	}
	
	@GetMapping("/findId")
	public String findIdFrom(Model model) {
		model.addAttribute("fiDTO", new FindIdDTO());
		return "/member/findId";
	}
	
	@PostMapping("/findId")
	public String findIdPost(@Validated @ModelAttribute("fiDTO")FindIdDTO fiDTO, 
			BindingResult bindingResult, RedirectAttributes rttr) {
		
		if(bindingResult.hasErrors()) {
			return "/member/findId";
		}
		String memberId = msv.findId(fiDTO);
		log.info("memberId############", memberId);
		
		if(memberId != null) {
			rttr.addFlashAttribute("memberId", memberId);
			return "redirect:/member/findIdResult";
		}
		
		rttr.addFlashAttribute("isOk", 1);
		return "redirect:/member/findId";
	}
	
	@GetMapping("/findIdResult")
	public String findIdResult() {
		return "/member/findIdResult";
	}
	
	@GetMapping("/findPwd")
	public String findPwdFrom() {
		
		return "/member/findPwd";
	}
	
	@PostMapping("/findPwd")
	public String findPwdPost(@Validated @ModelAttribute("fiDTO")FindPwdDTO fpDTO, 
			BindingResult bindingResult, RedirectAttributes rttr) {
		
		
		int isPwd = msv.findPwd(fpDTO);
		if(isPwd == 0) {
			rttr.addFlashAttribute("isPwd", isPwd);
			return "redirect:/member/login";
		}
		
		String tempPwd = mailService.pwdEmail(fpDTO.getMemberEmail());

		String memberPwd = bcEncoder.encode(tempPwd);
		fpDTO.setMemberPwd(memberPwd);
			
		msv.findPwdUpdate(fpDTO);
			
		rttr.addFlashAttribute("isPwd", isPwd);
		return "redirect:/member/login";
		
	}
	
	@GetMapping("/memberQna")
	public void memberQna(HttpSession ses, Model m, PagingVO pgvo, @AuthUser MemberVO mvo) {
		pgvo.setType("w");
		if (mvo.getMemberType().equals("normal")) {
			pgvo.setKeyword(mvo.getMemberId());			
		}else {
			pgvo.setKeyword(mvo.getMemberEmail());
		}
		m.addAttribute("list", qsv.qnaList(pgvo));
		m.addAttribute("blist", bsv.busReserveList(pgvo));
		int totalCount = qsv.getTotalCount(pgvo);
		PagingHandler ph = new PagingHandler(pgvo, totalCount);
		log.info(">>>>ph>>>"+ ph);
		m.addAttribute("ph",ph);
		m.addAttribute("mvo", mvo);
	}
	
	
	
	
	
	
	
	// sub 로그아웃 컨트롤러
	@GetMapping("/logoutSub")
	public String logoutTab(HttpServletRequest request, HttpServletResponse response) {
		logout(request, response);
		return "redirect:/";
	}
	
	/**
	 * @param request (회원정보)
	 * @param response (응답정보)
	 * 시큐리티 로그아웃 사용시 필요 객체
	 */
	private void logout(HttpServletRequest request, HttpServletResponse response) {
		//사용자 정보를 찾는 인자
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		new SecurityContextLogoutHandler().logout(request, response, auth);
	}
		
	
}
