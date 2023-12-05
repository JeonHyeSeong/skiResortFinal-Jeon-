package com.web.www.controller;


import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.web.www.domain.FileVO;
import com.web.www.domain.board.NoticeDTO;
import com.web.www.domain.board.NoticeVO;
import com.web.www.domain.board.PagingVO;
import com.web.www.handler.FileHandler;
import com.web.www.handler.PagingHandler;
import com.web.www.service.NoticeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;



@Slf4j
@Controller
@RequestMapping("/notice/*")
@RequiredArgsConstructor
public class NoticeController {
	
	private final NoticeService nsv;
	
	private final FileHandler fh;
	
	
	
	@PostMapping(value="/uploadSummernoteImageFile", produces = "application/json")
	@ResponseBody
	public JsonObject uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile) {
		
		JsonObject jsonObject = new JsonObject();
		
		String fileRoot = "D:\\summernote_image\\";	//저장될 외부 파일 경로
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
				
		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		
		File targetFile = new File(fileRoot + savedFileName);	
		
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "/summernoteImage/"+savedFileName);
			jsonObject.addProperty("responseCode", "success");
				
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		
		return jsonObject;
	}
	
	
	
	

	
	@GetMapping("/register")
	public String noticeRegister(HttpSession ses) {
		String memberId = (String) ses.getAttribute("memberId");	
		log.info("@@@@@ = {}", memberId);
		return "/notice/register";
	}
	

	
	//파일업로드 추가
	@PostMapping("/register")
	public String noticeRegister(NoticeVO nvo, RedirectAttributes re,
			@RequestParam(name="files", required = false)MultipartFile[] files) {
		log.info(" >>>>> register "+nvo+" "+files);
		List<FileVO> flist = null;
		if(files[0].getSize() > 0) {
			String category ="notice";
			flist = fh.uploadFiles(files,category);
		}
		int isOk = nsv.noticeRegister(new NoticeDTO(nvo, flist));
		log.info(">>>>> notice register >> "+(isOk > 0? "OK" : "Fail"));
		return "redirect:/notice/list";
	}
	
	
	
	//페이징 추가
	@GetMapping("/list")
	public void noticeList(Model m, PagingVO pgvo) {
		m.addAttribute("list", nsv.noticeList(pgvo));
		int totalCount = nsv.getTotalCount(pgvo);
		PagingHandler ph = new PagingHandler(pgvo, totalCount);
		m.addAttribute("ph",ph);
		List<NoticeVO> pvo = nsv.noticePointList();
		m.addAttribute("pvo", pvo);
	}
	
	
	
	//공지두개 비동기로 보내기
	@GetMapping(value="/getTwoNotice", produces = {MediaType.APPLICATION_JSON_VALUE} )
	public ResponseEntity<List<NoticeVO>> getTwoNotice() {
		List<NoticeVO> list  = nsv.getTwoNotice();
		log.info("lsit>>>>>>>>>>"+list);
		int isOk=0;
		if(list != null && !list.isEmpty()) {
			isOk=1;
			
		}
		log.info(isOk+"isOk<<<<<<<<");
		return isOk > 0 ? new ResponseEntity<List<NoticeVO>>(list, HttpStatus.OK)
				: new ResponseEntity<List<NoticeVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	

	
	//파일업로드 추가
	@GetMapping({"/detail","/modify"})
	public void noticeDetail(Model m, @RequestParam("noticeNum")long noticeNum) {
		NoticeDTO ndto = nsv.noticeDetail(noticeNum);
		m.addAttribute("ndto",ndto);
	}
	
	
	//파일업로드 추가
	@PostMapping("/modify")
	public String noticeModify(NoticeVO nvo, RedirectAttributes re,
			@RequestParam(name="files", required = false)MultipartFile[] files) {
		log.info(" >>>>> modify "+nvo+" "+files);
		
		List<FileVO> flist = null;
		if(files[0].getSize() > 0) {
			String category ="notice";
			flist = fh.uploadFiles(files,category);
		}
		NoticeDTO ndto = new NoticeDTO(nvo, flist);
		int isOk = nsv.noticeFileModify(ndto);
		log.info(">>>>> notice modify >> "+(isOk > 0? "OK" : "Fail"));
		re.addFlashAttribute("isOk",isOk);
		return "redirect:/notice/detail?noticeNum="+nvo.getNoticeNum();
	}
	
	
	@GetMapping("/remove")
	public String noticeRemove(@RequestParam("noticeNum")long noticeNum, RedirectAttributes re) {
		int isOk = nsv.noticeRemove(noticeNum);
		log.info(">>>>> notice remove >> "+(isOk > 0? "OK" : "Fail"));
		re.addFlashAttribute("isOk", isOk);
		return "redirect:/notice/list";
	}
	
	@DeleteMapping(value = "/file/{uuid}")
	public ResponseEntity<String> noticeRemoveFile(@PathVariable("uuid") String uuid){
		log.info(">>>>파일삭제확인 uuid >>"+uuid);
		int isOk = nsv.noticeRemoveFile(uuid);
		return isOk > 0 ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	
	
	
	
//	@PostMapping("/register")
//	public String noticeRegister(NoticeVO nvo, Model m) {
//		int isOk = nsv.noticeRegister(nvo);
//		log.info(">>>>> notice register >> "+(isOk > 0? "OK" : "Fail"));
//		return "redirect:/notice/list";
//	}

	
//	@GetMapping("/list")
//	public String noticeList(Model m) {
//		List<NoticeVO> list = nsv.noticeList();
//		m.addAttribute("list", list);
//		return "/notice/list";
//	}
	
	
//	@GetMapping("/list")
//	public void noticeList(Model m) {
//		List<NoticeVO> list = nsv.noticeList();
//		m.addAttribute("list", list);	
//	}
	
	
//	@GetMapping({"/detail","/modify"})
//	public void noticeDetail(Model m, @RequestParam("noticeNum")long noticeNum) {
//		NoticeVO nvo = nsv.noticeDetail(noticeNum);
//		m.addAttribute("nvo",nvo);
//	}
	
	
//	@PostMapping("/modify")
//	public String noticeModify(NoticeVO nvo) {
//		int isOk = nsv.noticeModify(nvo);
//		log.info(">>>>> notice modify >> "+(isOk > 0? "OK" : "Fail"));
//		return "redirect:/notice/list";
//	}
	
	
}
