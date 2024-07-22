package com.tg.mappers;

import com.tg.vo.AreaBasedListVO;
import com.tg.vo.BoardVO;
import com.tg.vo.SearchFestivalVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SearchMapper {

    List<AreaBasedListVO.Item> searchContent(@Param("keyword") String keyword);
    List<SearchFestivalVO.Item> searchFestival(@Param("keyword") String keyword);
    List<BoardVO> searchBoard(@Param("keyword") String keyword);
}
