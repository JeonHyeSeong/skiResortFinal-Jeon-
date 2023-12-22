
package com.web.www.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.web.www.domain.coupon.Coupon;
import com.web.www.domain.hotel.RoomDetailImageVO;
import com.web.www.domain.hotel.RoomInfoVO;
import com.web.www.domain.hotel.RoomVO;
import com.web.www.repository.HotelDAO;
import com.web.www.repository.MemberDAO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class HotelServiceImpl implements HotelService{

	private final HotelDAO hdao;
	
	@Transactional
	@Override
	public int updateRoomInfo(RoomInfoVO rivo) {
		int isOk = hdao.updateRoomInfo(rivo);
		hdao.updateRoomCount();
		return isOk ;
	}

	@Override
	public int addRoom(RoomVO rvo) {
		// TODO Auto-generated method stub
		
		return hdao.addRoom(rvo);
	}

	@Override
	public List<RoomVO> getRoomList() {
		// TODO Auto-generated method stub
		return hdao.getRoomList();
	}

	@Override
	public int deleteRoom(int hotelRoomNum) {
		// TODO Auto-generated method stub
		return hdao.deleteRoom(hotelRoomNum);
	}

	@Override
	public int modifyRoom(RoomVO rvo) {
		// TODO Auto-generated method stub
		return hdao.modifyRoom(rvo);
	}

	@Override
	public int selectRoomCnt() {
		// TODO Auto-generated method stub
		return hdao.selectRoomCnt();
	}

	@Override
	public int cheakRoomCount(int hotelRoomNum) {
		// TODO Auto-generated method stub
		return hdao.getRoomCount(hotelRoomNum);
	}

	@Override
	public RoomVO getRoomDetail(int roomNum) {
		// TODO Auto-generated method stub
		return hdao.getRoomDetail(roomNum);
	}

	@Override
	public void addRoomImage(RoomDetailImageVO roomDetailImageVO) {
		log.info(roomDetailImageVO+"roomDetailImageVO");
		hdao.addRoomImage(roomDetailImageVO);
		
	}

	@Override
	public RoomDetailImageVO getRoomDetailImageVO(int roomNum) {
		
		return hdao.getRoomDetailImageVO(roomNum);
	}

	@Override
	public List<RoomDetailImageVO> getimageList() {
		// TODO Auto-generated method stub
		return hdao.getimageList();
	}

}
