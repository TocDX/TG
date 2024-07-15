package com.tg.ctl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.tg.svc.FestivalServiceImpl;
import com.tg.vo.SearchFestivalVO;



@Controller
public class FestivalController {


	@Autowired
	private FestivalServiceImpl festivalService;


	@RequestMapping(value = "/festival_insert", method = RequestMethod.GET)
	public void ctlFestivalInsert() {

		ArrayList<String> eventStartDateList = new ArrayList<String>();
		for(int i=20240701; i<=20240711; i++ ) {
			eventStartDateList.add(20240711+"");
		}

		for(String eventStartDate : eventStartDateList){
			String searchFestival1URL = "https://apis.data.go.kr/B551011/KorService1/searchFestival1?serviceKey=IEAfst0yD405EXxf26rShE6VD2bGEKKUDghmNDzW4%2FxnEUbTD5ayrg3g4JnwajyOHm0MicV%2FFiqXjRo7jJT8%2FA%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&_type=json&listYN=Y&arrange=A&eventStartDate=" + eventStartDate ;  //20240711";
			ArrayList<HashMap<String,String>> contentsIdList = new ArrayList<HashMap<String,String>>();

			try {
				// URL 객체 생성
				URL url = new URL(searchFestival1URL);
				// HttpURLConnection 객체 생성
				HttpURLConnection connection = (HttpURLConnection) url.openConnection();
				connection.setRequestMethod("GET"); // 요청 방식 설정
				connection.setRequestProperty("Accept", "application/json"); // JSON 응답 요청

				// 응답 코드 확인
				int responseCode = connection.getResponseCode();
				System.out.println("Response Code: " + responseCode);

				if (responseCode == HttpURLConnection.HTTP_OK) { // 응답이 정상인 경우
					// 응답 데이터 읽기
					BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
					String inputLine;
					StringBuilder response = new StringBuilder();

					while ((inputLine = in.readLine()) != null) {
						response.append(inputLine);
					}
					in.close();

					// 응답 내용 출력
					System.out.println("Response JSON: " + response.toString());
					Gson gson = new Gson();
					//{"response": {"header":{"resultCode":"0000","resultMsg":"OK"},"body": {"items": {"item":[{"addr1":"강원특별자치도 강릉시 임영로131번길 6","addr2":"강릉대도호부관아","booktour":"","cat1":"A02","cat2":"A0207","cat3":"A02070200","contentid":"2541883","contenttypeid":"15","createdtime":"20180406184032","eventstartdate":"20240815","eventenddate":"20240817","firstimage":"http://tong.visitkorea.or.kr/cms/resource/77/3317777_image2_1.jpg","firstimage2":"http://tong.visitkorea.or.kr/cms/resource/77/3317777_image3_1.jpg","cpyrhtDivCd":"Type3","mapx":"128.8921226461","mapy":"37.7532767444","mlevel":"6","modifiedtime":"20240620170745","areacode":"32","sigungucode":"1","tel":"033-823-3224","title":"강릉 문화유산 야행"}]},"numOfRows":10,"pageNo":1,"totalCount":260}}}

					//----------------하단 ** 코드 ResponseVO 바꿔치기
					SearchFestivalVO rvo = gson.fromJson(response.toString(), SearchFestivalVO.class);
					System.out.println(rvo.getResponse().getBody().getItems().getItem().toString());


					List<SearchFestivalVO.Item>  itemsList = rvo.getResponse().getBody().getItems().getItem();
					festivalService.svcFestivalInsert(itemsList);
					
					

				} else {
					System.out.println("GET request not worked");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}	
