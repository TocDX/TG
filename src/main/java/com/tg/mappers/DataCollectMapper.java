package com.tg.mappers;

import java.util.List;
import java.util.Map;

import com.tg.vo.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface DataCollectMapper {
    List<DetailCommonVO.Item> selectLocations ();
    boolean isFestivalExists(String contentid);
    int insertFestival(SearchFestivalVO.Item item);  
    List<SearchFestivalVO.Item> selectFestival();
    List<AreaBasedListVO.Item> daejeonRegionSelectOne(String contentid);
    List<AreaBasedListVO.Item> daejeonRegionList(AreaBasedListVO.Item areaVO);
    List<AreaBasedListVO.Item> selectSeoulRegion( );
    List<DetailIntroVO.Item> introFestival(String contentid);
    List<AreaBasedListVO.Item> busanRegionList(AreaBasedListVO.Item areaVO);
    List<AreaBasedListVO.Item> daeguRegionList(AreaBasedListVO.Item areaVO);
    List<AreaBasedListVO.Item> selectSeoulRegionPagination(AreaBasedListVO.Item areaVO);
    List<AreaBasedListVO.Item> seoulRegionSelectOne(@Param("contentid")String contentid);
    List<DetailCommonVO.Item> seoulRegionCommSelectOne(@Param("contentid")String contentid);
    List<SearchFestivalVO.Item> festivalSelectOne(@Param("contentid")  String contentid);
    List<SearchFestivalVO.Item> joinFestivalIntro();
    List<DetailIntroVO.Item> selectDetailIntro();
   
    int viewCount(@Param("contentid")  String contentid);
    int viewCommonCount(@Param("contentid")  String contentid);
    List<SearchFestivalVO.Item> selectSearchEvent(SearchFestivalVO.Item eventVO);
    List<SearchFestivalVO.Item> selectSearchFestival(SearchFestivalVO.Item searchFestivalVO);
    List<SearchFestivalVO.Item> eventSelectOne(@Param("contentid")  String contentid);
    List<AreaBasedListVO.Item>seoulRegionMap(String contenttypeid);
    int insertDetailIntro(DetailIntroVO.Item item);
    int insertCommon(DetailCommonVO.Item item);
    List<DetailCommonVO.Item> selectCommonDetail();
    int insertImage(DetailImageVO.Item item);
     int boardSeoulCount();
     int boardSearchFestivalCount();
     int boardCourseCount();
}

