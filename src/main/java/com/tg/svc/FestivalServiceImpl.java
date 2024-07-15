package com.tg.svc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tg.mappers.FestivalMapper;
import com.tg.vo.SearchFestivalVO;

@Service
public class FestivalServiceImpl {
	
	@Autowired
	FestivalMapper festivalMapper;
	
	public void svcFestivalInsert(List<SearchFestivalVO.Item> itemsList) {
		int insertRows = 0;
		for(SearchFestivalVO.Item item : itemsList) {
			
			System.out.println(item.getContenttypeid());
			festivalMapper.insertFestival(item);
			insertRows++;
		}
		System.out.println(insertRows + "건 입력");
	}
}
