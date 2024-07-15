package com.tg.mappers;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.tg.vo.SearchFestivalVO;

@Repository
@Mapper
public interface FestivalMapper {
    
    int insertFestival(SearchFestivalVO.Item item);  
}

