package com.web.www.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.www.domain.FileVO;
import com.web.www.domain.rental.RentalItemDTO;
import com.web.www.domain.rental.RentalItemListDTO;
import com.web.www.domain.rental.RentalLiftVO;
import com.web.www.domain.rental.RentalVO;
import com.web.www.repository.FileDAO;
import com.web.www.repository.RentalDAO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RentalServiceImpl implements RentalService{

	private final RentalDAO rdao;
	
	private final FileDAO fdao;

	@Override
	public int liftReserve(RentalLiftVO rlivo) {
		return rdao.liftReserve(rlivo);
	}

	@Override
	public int rental(RentalVO rvo) {
		
		return rdao.rental(rvo);
	}

//	@Override
//	public int itemRegister(RentalItemVO ritvo) {
//		
//		return rdao.itemRegister(ritvo);
//	}

	@Transactional
	@Override
	public int itemRegister(RentalItemDTO rdto) {
		long tempNum = rdao.selectOneItemNum();
		rdto.getRitvo().setRentalListItemNum(tempNum+1);
		
		int isOk = rdao.itemRegister(rdto.getRitvo());
		
		if(rdto.getFlist() == null) {
			return isOk;
		}
		
		if(isOk > 0 && rdto.getFlist().size() > 0) {
			long rentalListItemNum = rdao.selectOneItemNum();
			for(FileVO fvo : rdto.getFlist()) {
				fvo.setRentalListItemNum(rentalListItemNum);
				isOk *= fdao.insertItemFile(fvo);
			}
		}
		
		return isOk;
	}

	// 스키장비 등급(일반,중급,프리미엄)에 따라 분류
	@Override
	public List<RentalItemListDTO> getSkiLowItem() {
		
		return rdao.getSkiLowItem();
	}
	@Override
	public List<RentalItemListDTO> getSkiMidItem() {
		
		return rdao.getSkiMidItem();
	}
	@Override
	public List<RentalItemListDTO> getSkiPremiumItem() {
		
		return rdao.getSkiPremiumItem();
	}

	
	// 보드장비 등급(일반,중급,프리미엄)에 따라 분류
	@Override
	public List<RentalItemListDTO> getBoardLowItem() {
		
		return rdao.getBoardLowItem();
	}
	@Override
	public List<RentalItemListDTO> getBoardMidItem() {
		
		return rdao.getBoardMidItem();
	}
	@Override
	public List<RentalItemListDTO> getBoardPremiumItem() {
		
		return rdao.getBoardPremiumItem();
	}

	
	// 의류 등급(일반,중급,프리미엄)에 따라 분류
	@Override
	public List<RentalItemListDTO> getWearLowItem() {
		
		return rdao.getWearLowItem();
	}
	@Override
	public List<RentalItemListDTO> getWearMidItem() {
		
		return rdao.getWearMidItem();
	}
	@Override
	public List<RentalItemListDTO> getWearPremiumItem() {
		
		return rdao.getWearPremiumItem();
	}

	@Override
	public int rentalItemCntCheck() {
		return rdao.rentalItemCntCheck();
	}

	@Override
	public int rentalItemImageCntCheck() {
		
		return rdao.rentalItemImageCntCheck();
	}


	




}
