package com.tg.svc;

import com.tg.mappers.SearchMapper;
import com.tg.vo.AreaBasedListVO;
import com.tg.vo.BoardVO;
import com.tg.vo.SearchFestivalVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class SearchServiceImpl {

    @Autowired
    private SearchMapper searchMapper;



    public List<AreaBasedListVO.Item> searchContent(String keyword) {
        return searchMapper.searchContent(keyword);
    }


    public List<SearchFestivalVO.Item> searchFestival(String keyword) {
        return searchMapper.searchFestival(keyword);
    }


    public List<BoardVO> searchBoard(String keyword) {
        return searchMapper.searchBoard(keyword);
    }

}
