package com.tg.svc;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tg.mappers.RegionMapper;
import com.tg.vo.AreaBasedListVO;

@Service
public class RegionServiceImpl {

	@Autowired
	RegionMapper regionMapper;
	
	public void svcRegionInsert (List<AreaBasedListVO.Item> itemsList) {
		int insertRows = 0;
		for(AreaBasedListVO.Item item : itemsList) {
			System.out.println(item.getContenttypeid());
			regionMapper.insertRegion(item);
			insertRows++;
		}
		System.out.println(insertRows + "건 입력");
	}
	
}
