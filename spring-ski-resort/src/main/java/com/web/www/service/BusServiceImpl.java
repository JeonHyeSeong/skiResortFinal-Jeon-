package com.web.www.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.www.domain.alarm.AlarmVO;
import com.web.www.domain.board.PagingVO;
import com.web.www.domain.bus.BusInfoVO;
import com.web.www.domain.bus.BusVO;
import com.web.www.repository.AlarmDAO;
import com.web.www.repository.BusDAO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BusServiceImpl implements BusService{
	
	private final BusDAO bdao;
	private final AlarmDAO adao;

	@Transactional
	@Override
	public int busReserve(BusVO bvo) {
		bdao.updateBusCount(bvo);
		adao.alarmSetting(new AlarmVO(bvo.getMemberNum(), 8, "버스"));
		return bdao.busReserve(bvo);
	}

	@Override
	public int busCount() {
		
		return bdao.busCount();
	}

	@Override
	public void addBusInfo(BusInfoVO busInfoVO) {
		bdao.addBusInfo(busInfoVO);
		
	}

	@Override
	public List<BusVO> busReserveList(PagingVO pgvo) {
		
		return bdao.busReserveList(pgvo);
	}

	@Override
	public int getMemberBusCheck(long memberNum) {
		// TODO Auto-generated method stub
		return bdao.getMemberBusCheck(memberNum);
	}
	
	
	@Transactional
	@Override
	public BusVO busCancel(long busReserveNum, long memberNum) {
		BusVO bvo = bdao.busReserveInfo(busReserveNum, memberNum);
		
		if(bvo != null && "N".equals(bvo.getBusCancel())) {
			bvo.setBusCancel("Y");
			bdao.updateBusReserve(bvo);
			
			BusInfoVO bivo = bdao.findBusInfo(bvo.getBusNum());
			
			if(bivo != null) {
				int newBusCount = bivo.getBusPeopleLimit() + bvo.getBusPeople();
				bivo.setBusPeopleLimit(newBusCount);
				bdao.updateBusInfo(bivo);
			}
		}
		adao.alarmSetting(new AlarmVO(memberNum, 9, "버스"));
		return bvo;
		
	}

}
