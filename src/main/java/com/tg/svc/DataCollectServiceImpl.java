package com.tg.svc;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.tg.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tg.mappers.DataCollectMapper;

import javax.transaction.Transactional;

@Service
public class DataCollectServiceImpl {
	
	@Autowired
	DataCollectMapper dataCollectMapper;

	@Autowired
	private UserService userService;




	public List<SearchFestivalVO.Item> svcFestivalSelect() {
		List<SearchFestivalVO.Item> list = dataCollectMapper.selectFestival();
		System.out.println(list.size() + "건 가져오기");
		return list;
	}
	
	public List<SearchFestivalVO.Item> svcJoinFestivalIntro() {
		List<SearchFestivalVO.Item> list = dataCollectMapper.joinFestivalIntro();
		System.out.println(list.size() + "건 가져오기");
		return list;
	}
	public int svcBoardSearchFestivalCount(){
		return dataCollectMapper.boardSearchFestivalCount();
	}

	public int svcBoardCourseCount(){
		return dataCollectMapper.boardCourseCount();
	}
	public List<SearchFestivalVO.Item> svcFestivalViewCnt(String contentid){
		dataCollectMapper.viewCount(contentid);
		List<SearchFestivalVO.Item> result = dataCollectMapper.festivalSelectOne(contentid);
		System.out.println("Fetched Event Details: " + result);
		return result;
	}

	public List<SearchFestivalVO.Item> svcViewCnt(String contentid){
		dataCollectMapper.viewCount(contentid);
		List<SearchFestivalVO.Item> result = dataCollectMapper.eventSelectOne(contentid);
		System.out.println("Fetched Event Details: " + result);
		return result;
	}
	public List<AreaBasedListVO.Item> seoulRegionSelectOne(String contentid){

		List<AreaBasedListVO.Item> result = dataCollectMapper.seoulRegionSelectOne(contentid);
		System.out.println("Fetched Event Details: " + result);
		return result;
	}

	public int svcBoardRegionCount(){
		return dataCollectMapper.boardSeoulCount();
	}
	public List<AreaBasedListVO.Item> svcSelectSeoulRegion(){
		List<AreaBasedListVO.Item> list = dataCollectMapper.selectSeoulRegion();

		return list;
	}

	public List<AreaBasedListVO.Item> svcDaejeonRegionSelectOne(String contentid){
		return dataCollectMapper.daejeonRegionSelectOne(contentid);
	}

	public List<AreaBasedListVO.Item> svcDaejeonRegionList(AreaBasedListVO.Item areaVO){
		List<AreaBasedListVO.Item> list = dataCollectMapper.daejeonRegionList(areaVO);

		return list;
	}

	public List<AreaBasedListVO.Item> svcSelectBusanRegionPagination(AreaBasedListVO.Item areaVO){
		List<AreaBasedListVO.Item> list = dataCollectMapper.busanRegionList(areaVO);

		return list;
	}
	public List<AreaBasedListVO.Item> svcSelectDaeguRegionPagination(AreaBasedListVO.Item areaVO){
		List<AreaBasedListVO.Item> list = dataCollectMapper.daeguRegionList(areaVO);

		return list;
	}


	public List<AreaBasedListVO.Item> svcSelectSeoulRegionPagination(AreaBasedListVO.Item areaVO){
		List<AreaBasedListVO.Item> list = dataCollectMapper.selectSeoulRegionPagination(areaVO);

		return list;
	}


	public List<SearchFestivalVO.Item> svcSelectSearchFestival(SearchFestivalVO.Item searchFestivalVO ){
		List<SearchFestivalVO.Item> list = dataCollectMapper.selectSearchFestival(searchFestivalVO);
		return list;
	}
	public List<AreaBasedListVO.Item> seoulRegionMapList(String contenttypeid){
		return dataCollectMapper.seoulRegionMap(contenttypeid);
	}


	public List<SearchFestivalVO.Item> svcFestivalSelectOne(String contentid){
		return dataCollectMapper.festivalSelectOne(contentid);
	}
	public List<SearchFestivalVO.Item> svcEventSelectOne(String contentid){
		return dataCollectMapper.eventSelectOne(contentid);
	}
	public List<DetailCommonVO.Item> svcSeoulRegionCommSelectOne(String contentid){
		dataCollectMapper.viewCommonCount(contentid);
		List<DetailCommonVO.Item> result = dataCollectMapper.seoulRegionCommSelectOne(contentid);
		System.out.println("Fetched Event Details: " + result);
		return result;
	}
	public  List<DetailIntroVO.Item> svcDetailIntroSelectOne(String contentid){
		return dataCollectMapper.introFestival(contentid);
	}
	public List<DetailCommonVO.Item> svcLocation(){
		return dataCollectMapper.selectLocations();
	}
	public void svcFestivalInsert(List<SearchFestivalVO.Item> itemsList) {
		int insertRows = 0;
		for (SearchFestivalVO.Item item : itemsList) {
			if (!dataCollectMapper.isFestivalExists(item.getContentid())) { // 중복 확인
				System.out.println("Inserting: " + item.getTitle());
				dataCollectMapper.insertFestival(item);
				insertRows++;
			} else {
				System.out.println("Duplicate found: " + item.getTitle());
			}
		}
		System.out.println(insertRows + "건 입력");
	}
	
	public void svcIntroInsert(List<DetailIntroVO.Item> itemsList) {
		int insertRows = 0;
		for(DetailIntroVO.Item item : itemsList) {
			System.out.println(item.getContenttypeid());
			dataCollectMapper.insertDetailIntro(item);
			insertRows++;
		}
		System.out.println(insertRows + "건 입력");
	}

	
	public List<DetailIntroVO.Item> svcSelectIntro(){
		List<DetailIntroVO.Item> list = dataCollectMapper.selectDetailIntro();
		System.out.println(list.size() + "건 가져오기");
		return list;
	}


	public void svcCommonInsert(List<DetailCommonVO.Item> itemsList) {
		int insertRows = 0;
		for(DetailCommonVO.Item item : itemsList) {
			System.out.println(item.getContenttypeid());
			dataCollectMapper.insertCommon(item);
			insertRows++;
		}
		System.out.println(insertRows + "건 입력");
	}

	public List<DetailCommonVO.Item> svcSelectCommon(){
		List<DetailCommonVO.Item> list = dataCollectMapper.selectCommonDetail();
		System.out.println(list.size() + "건 가져오기");
		return  list;
	}
	public List<SearchFestivalVO.Item> svcSelectSearchEvent(SearchFestivalVO.Item eventVO){
		List<SearchFestivalVO.Item> list = dataCollectMapper.selectSearchEvent(eventVO);
		return list;
	}

	public void svcImageInsert(List<DetailImageVO.Item> itemsList) {
		int insertRows = 0;
		for(DetailImageVO.Item item : itemsList) {
			System.out.println(item.getSerialnum());
			dataCollectMapper.insertImage(item);
			insertRows++;
		}
		System.out.println(insertRows + "건 입력");
	}
}
