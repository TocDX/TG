package com.tg.ctl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.tg.svc.RegionServiceImpl;
import com.tg.vo.AreaBasedListVO;

@Controller
public class RegionController {

	
	@Autowired
	private RegionServiceImpl regionService;

	
	@RequestMapping(value = "/region_insert", method = RequestMethod.GET)
	public void ctlRegionInsert() {
		
		double mapX = 126.9780;
		double mapY = 37.5665;
		int radius = 10000;
		  //String contentTypeId = "12";
		  String areaBasedList1URL = "https://apis.data.go.kr/B551011/KorService1/locationBasedList1?serviceKey=%2FsnREDEo9wDvjDZdYPQBziVifQv%2BmujykTnwFyL22gQE5TkARhP5SNBhFW3xnnwf0fxTTLNUrr8doJEgE7bf9Q%3D%3D&MobileOS=ETC&MobileApp=AppTest&listYN=Y&arrange=S&_type=Json&mapX="+mapX+"&mapY="+mapY+"&radius="+radius+"&numOfRows=1000&pageNo=1";
		  try {
		      // URL 객체 생성
		      URL url = new URL(areaBasedList1URL);
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
		          AreaBasedListVO rvo = gson.fromJson(response.toString(), AreaBasedListVO.class);
		          System.out.println(rvo.getResponse().getBody().getItems().getItem().toString());
		
		          List<AreaBasedListVO.Item>  itemsList = rvo.getResponse().getBody().getItems().getItem();
		          regionService.svcRegionInsert(itemsList);
		          
		          
//				for(AreaBasedListVO.Item v : itemsList) {
//					System.out.println("**" + v.getDist());
//					System.out.println("**" + v.getTitle());
//				}
					
		      } else {
		          System.out.println("GET request not worked");
		      }
		  } catch (Exception e) {
		      e.printStackTrace();
		  }
	}
}
