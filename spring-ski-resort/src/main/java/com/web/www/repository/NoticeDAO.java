package com.web.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.web.www.domain.board.NoticePagingVO;
import com.web.www.domain.board.NoticeVO;

public interface NoticeDAO {

	int insert(NoticeVO nvo);

	NoticeVO selectDetail(long noticeNum);

	List<NoticeVO> selectList(NoticePagingVO npvo);

	int update(NoticeVO nvo);

	int delete(long noticeNum);

	int getTotalCount(NoticePagingVO npvo);

	void readCount(@Param("noticeNum")long noticeNum, @Param("cnt")int cnt);

}