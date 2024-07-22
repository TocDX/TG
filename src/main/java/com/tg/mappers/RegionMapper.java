package com.tg.mappers;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.tg.vo.AreaBasedListVO;

@Repository
@Mapper
public interface RegionMapper {

	int insertRegion (AreaBasedListVO.Item item);
	
	
}
