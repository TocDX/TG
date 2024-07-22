package com.tg.ctl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.*;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tg.common.PagingUtil;
import com.tg.svc.BoardService;
import com.tg.svc.UserService;
import com.tg.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.tg.svc.DataCollectServiceImpl;
import com.tg.vo.DetailIntroVO.Item;

import javax.servlet.http.HttpServletResponse;


@Controller

public class DataCollectController {

	@Autowired
	private UserService userService;
	@Autowired
	private DataCollectServiceImpl dataCollectService;





	// --------------------------------------------------------------------------------------------------------------------------
	// jsp  조회 인서트
	@RequestMapping(value = "/index" , method = RequestMethod.GET)
	public String ctlIndex(Model model) {
		ArrayList<AreaBasedListVO.Item> arealist = (ArrayList)dataCollectService.svcSelectSeoulRegion();
		ArrayList<SearchFestivalVO.Item> fetivallist = (ArrayList)dataCollectService.svcFestivalSelect();

		model.addAttribute("KEY_REGIONINDEXLIST", arealist);
		model.addAttribute("KEY_FESTIVALLIST", fetivallist);
		return "index";
	}

	@RequestMapping(value = "/region_list" , method = RequestMethod.GET)
	public String ctlRegionList(Model model , @RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage ) {
		int listCount = dataCollectService.svcBoardRegionCount();
		PagingUtil page = new PagingUtil("/region_list?", currentPage,listCount,12,5);
		String pageHtmlStr = page.getPagingHtml().toString();
		AreaBasedListVO.Item areaVO = new AreaBasedListVO.Item();


		ArrayList<AreaBasedListVO.Item> list = (ArrayList)dataCollectService.svcSelectSeoulRegionPagination(areaVO);


		model.addAttribute("KEY_REGIONLIST", list);
		model.addAttribute("KEY_PAGEING_HTML", pageHtmlStr);
		return "region/region_list";
	}

	@RequestMapping(value="/event_list", method = RequestMethod.GET)
	public String ctlEventList(Model model, @RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage){
		int listCount = dataCollectService.svcBoardRegionCount();
		PagingUtil page = new PagingUtil("/event_list?", currentPage,listCount,9,10);
		String pageHtmlStr = page.getPagingHtml().toString();
		SearchFestivalVO.Item eventVO = new SearchFestivalVO.Item();
		eventVO.setStartSeq(page.getStartSeq());
		eventVO.setEndSeq(page.getEndSeq());

		ArrayList<SearchFestivalVO.Item> festivalList = (ArrayList)dataCollectService.svcSelectSearchEvent(eventVO);

		System.out.println("festival" + festivalList);
		System.out.println("page"+ listCount);
		model.addAttribute("KEY_EVENTLIST", festivalList);
		model.addAttribute("KEY_PAGEING_HTML1", pageHtmlStr);
		return "fesival_event/event_list";
	}

	@RequestMapping(value = "/event_detail", method = RequestMethod.GET)
	public String ctlEventDetail(Model model, @RequestParam("contentid") String contentid){
		dataCollectService.svcViewCnt(contentid);
		List<SearchFestivalVO.Item> list = (List<SearchFestivalVO.Item>) dataCollectService.svcViewCnt(contentid);
		List<DetailCommonVO.Item> commonDetai2 = (List<DetailCommonVO.Item>) dataCollectService.svcSeoulRegionCommSelectOne(contentid);
		List<DetailIntroVO.Item> introDetail2 = (List<DetailIntroVO.Item>) dataCollectService.svcDetailIntroSelectOne(contentid);

		model.addAttribute("KEY_COMMONDETAIL2", commonDetai2);
		model.addAttribute("KEY_EVENTDETAIL", list);
		model.addAttribute("KEY_INTRO2", introDetail2);
		return "fesival_event/event_detail";
	}

	@RequestMapping(value="/festival_list", method = RequestMethod.GET)
	public String ctlFestivalList(Model model, @RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage){
		int listCount = dataCollectService.svcBoardRegionCount();
		PagingUtil page = new PagingUtil("/festival_list?", currentPage,listCount,5,10);
		String pageHtmlStr = page.getPagingHtml().toString();
		SearchFestivalVO.Item searchVO = new SearchFestivalVO.Item();
		searchVO.setStartSeq(page.getStartSeq());
		searchVO.setEndSeq(page.getEndSeq());

		ArrayList<SearchFestivalVO.Item> festivalList = (ArrayList)dataCollectService.svcSelectSearchFestival(searchVO);

		System.out.println("festival" + festivalList);
		System.out.println("page"+ listCount);
		model.addAttribute("KEY_FESTIVALLIST", festivalList);
		model.addAttribute("KEY_PAGEING_HTML", pageHtmlStr);
		return "fesival_event/festival_list";
	}
	@RequestMapping(value = "/region_detail", method = RequestMethod.GET)
	public String ctlRegionDetail(Model model, @RequestParam("contentid") String contentid){
		List<AreaBasedListVO.Item> list = (List<AreaBasedListVO.Item>) dataCollectService.seoulRegionSelectOne(contentid);
		List<DetailCommonVO.Item> commonDetail = (List<DetailCommonVO.Item>) dataCollectService.svcSeoulRegionCommSelectOne(contentid);
		System.out.println(list);
		model.addAttribute("KEY_COMMONDETAIL", commonDetail);
		model.addAttribute("KEY_REGIONDETAIL", list);
		return "region/region_detail";
	}
	@RequestMapping(value = "/travel", method = RequestMethod.GET)
	public String ctlMapList(Model model, @RequestParam("contenttypeid") String contenttypeid){
		List<AreaBasedListVO.Item> list = (List<AreaBasedListVO.Item>) dataCollectService.seoulRegionMapList(contenttypeid);
		System.out.println("list"+ list);
		model.addAttribute("KEY_REGIONDETAIL1", list);
		return "travel";
	}

	@RequestMapping(value = "/festival_detail", method = RequestMethod.GET)
	public String ctlFestivalDetail(Model model, @RequestParam("contentid") String contentid){
		List<SearchFestivalVO.Item> list = (List<SearchFestivalVO.Item>) dataCollectService.svcFestivalViewCnt(contentid);
		List<DetailCommonVO.Item> commonDetail = (List<DetailCommonVO.Item>) dataCollectService.svcSeoulRegionCommSelectOne(contentid);
		List<DetailIntroVO.Item> introDetail1 = (List<DetailIntroVO.Item>) dataCollectService.svcDetailIntroSelectOne(contentid);
		System.out.println("Intro : " + list);
		model.addAttribute("KEY_COMMONDETAIL1", commonDetail);
		model.addAttribute("KEY_FESTIDETAIL", list);
		model.addAttribute("KEY_INTRO1", introDetail1);
		return "fesival_event/festival_detail";
	}

	// rest controller

	@RequestMapping(value = "/region_data", produces = "application/json")
	@ResponseBody
	public ResponseEntity<List<AreaBasedListVO.Item>> getRegionData(Model model, @RequestParam String region,@RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage) {
		int listCount = dataCollectService.svcBoardRegionCount();
		PagingUtil page = new PagingUtil("/region_data?", currentPage, listCount, 8, 10);
		AreaBasedListVO.Item areaVO = new AreaBasedListVO.Item();
		String pageHtmlStr = page.getPagingHtml().toString();
		areaVO.setStartSeq(page.getStartSeq());
		areaVO.setEndSeq(page.getEndSeq());
		List<AreaBasedListVO.Item> list;
		if (region.equals("daegu")) {
			list = dataCollectService.svcSelectDaeguRegionPagination(areaVO);
		} else if (region.equals("daejeon")) {
			list = dataCollectService.svcDaejeonRegionList(areaVO);
		} else if (region.equals("busan")) {
			list = dataCollectService.svcSelectBusanRegionPagination(areaVO);
		} else {
			list = dataCollectService.svcSelectSeoulRegionPagination(areaVO);
		}

		model.addAttribute("KEY_PAGEING_HTML1", pageHtmlStr);
		return new ResponseEntity<List<AreaBasedListVO.Item>>(list, HttpStatus.OK);
	}

	@RequestMapping(value = "/travel_data", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<List<SearchFestivalVO.Item>> loadTravel(Model model, @RequestParam(value = "festival", required = false) String festival,@RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage) {
		int listCount = dataCollectService.svcBoardCourseCount();
		PagingUtil page = new PagingUtil("/travel_data?", currentPage, listCount, 8, 10);
		SearchFestivalVO.Item searchFestivalVO = new SearchFestivalVO.Item();
		String pageHtmlStr = page.getPagingHtml().toString();
		searchFestivalVO.setStartSeq(page.getStartSeq());
		searchFestivalVO.setEndSeq(page.getEndSeq());
		List<SearchFestivalVO.Item> list = dataCollectService.svcSelectSearchFestival(searchFestivalVO);
		System.out.println("List: " + list);

		model.addAttribute("KEY_PAGEING_HTML1", pageHtmlStr);
		return new ResponseEntity<List<SearchFestivalVO.Item>>(list, HttpStatus.OK);
	}

	@RequestMapping(value = "/event_data", method = RequestMethod.GET, produces = "application/json")
	@ResponseBody
	public ResponseEntity<List<SearchFestivalVO.Item>> loadEvent(Model model, @RequestParam(value = "event", required = false) String event,@RequestParam(value="currentPage", required=false, defaultValue="1") int currentPage) {
		int listCount = dataCollectService.svcBoardCourseCount();
		PagingUtil page = new PagingUtil("/event_data?", currentPage, listCount, 8, 10);
		SearchFestivalVO.Item searchFestivalVO = new SearchFestivalVO.Item();
		String pageHtmlStr = page.getPagingHtml().toString();
		searchFestivalVO.setStartSeq(page.getStartSeq());
		searchFestivalVO.setEndSeq(page.getEndSeq());
		List<SearchFestivalVO.Item> list = dataCollectService.svcSelectSearchEvent(searchFestivalVO);
		System.out.println("List: " + list);

		model.addAttribute("KEY_PAGEING_HTML1", pageHtmlStr);
		return new ResponseEntity<List<SearchFestivalVO.Item>>(list, HttpStatus.OK);
	}




}

