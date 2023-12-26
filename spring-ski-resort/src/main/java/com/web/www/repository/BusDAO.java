package com.web.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.web.www.domain.board.PagingVO;
import com.web.www.domain.bus.BusInfoVO;
import com.web.www.domain.bus.BusVO;

public interface BusDAO {

	int busReserve(BusVO bvo);

	int busCount();

	void addBusInfo(BusInfoVO busInfoVO);

	void updateBusCount(BusVO bvo);

	List<BusVO> busReserveList(PagingVO pgvo);

//	int busCancel();

	BusVO busReserveInfo(@Param("busReserveNum") long busReserveNum, @Param("memberNum") long memberNum);

	void updateBusReserve(BusVO bvo);

	BusInfoVO findBusInfo(int busNum);

	void updateBusInfo(BusInfoVO bivo);

	int getMemberBusCheck(long memberNum);

}
