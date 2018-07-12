package com.petmily.controller;

import java.io.BufferedInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import com.petmily.dto.AnimalDTO;
import com.petmily.dto.LocationDTO;
import com.petmily.dto.ShelterDTO;

@Controller
public class ApiController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	//보호소 전체 리스트
	ArrayList<ShelterDTO> shelterList = new ArrayList<ShelterDTO>();
	
	@RequestMapping(value = "apiPage")
	public String apiPage() {
		return "getApi";
	}
	
	@RequestMapping(value = "searchShelter")
	public String searchShelter(HttpSession session) {
		if(shelterList.isEmpty()) {
			try {
				JSONParser parser = new JSONParser();
				String dataFilePath = session.getServletContext().getRealPath("/resources/dataFile/shelter.json");
				Object obj = parser.parse(new FileReader(dataFilePath));
				JSONObject jsonObj = (JSONObject) obj;
				
				JSONArray arr = (JSONArray) jsonObj.get("records");
				
				for (int i = 0; i < arr.size(); i++) {
					JSONObject temp = (JSONObject) arr.get(i);
					ShelterDTO dto = new ShelterDTO();
					dto.setCenterName((String) temp.get("동물보호센터명"));
					dto.setManageName((String) temp.get("관리기관명"));
					dto.setCenterType((String) temp.get("동물보호센터유형"));
					dto.setRoadAddr((String) temp.get("소재지도로명주소"));
					dto.setLocationAddr((String) temp.get("소재지지번주소"));
					dto.setX((String) temp.get("위도"));
					dto.setY((String) temp.get("경도"));
					dto.setWeekdayStartTime((String) temp.get("평일운영시작시각"));
					dto.setWeekdayEndTime((String) temp.get("평일운영종료시각"));
					dto.setWeekendStartTime((String) temp.get("주말운영시작시각"));
					dto.setWeekendEndTime((String) temp.get("주말운영종료시각"));
					dto.setHoliday((String) temp.get("휴무일"));
					dto.setPhoneNum((String) temp.get("전화번호"));
					
					shelterList.add(dto);
					
					
				}
			} catch (IOException | ParseException e) {
				e.printStackTrace();
			}
		}
		return "searchShelter";
	}
	

/*	@RequestMapping(value = "getSido")
	public @ResponseBody ArrayList<LocationDTO> goQuizMain() {
		String addr = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/sido?ServiceKey=";
		String serviceKey = "XCdNWTVmXT3Zk0y%2BK3CpUAV2t4qBVGx34uevgRwA8jGhto%2FVOnbeSyfYnh74wEKL0DGPoql%2FDnZy6cjcbDGnHg%3D%3D";

		ArrayList<LocationDTO> list = null;
		LocationDTO dto = new LocationDTO();

		try {
			URL url = new URL(addr + serviceKey);

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			factory.setNamespaceAware(true);
			XmlPullParser parser = factory.newPullParser();
			BufferedInputStream bis = new BufferedInputStream(url.openStream());
			parser.setInput(bis, "utf-8");

			int eventType = parser.getEventType();

			while (eventType != XmlPullParser.END_DOCUMENT) {
				switch (eventType) {
				case XmlPullParser.END_DOCUMENT:
					break;
				case XmlPullParser.START_DOCUMENT:
					list = new ArrayList<LocationDTO>();
					break;
				case XmlPullParser.END_TAG: {
					String tag = parser.getName();
					if (tag.equals("item")) {
						list.add(dto);
						dto = null;
					}
				}
				case XmlPullParser.START_TAG: {
					String tag = parser.getName();
					switch (tag) {
					case "item":
						dto = new LocationDTO();
						break;

					case "orgCd":
						if (dto != null) {
							dto.setSidoCode(Integer.parseInt(parser.nextText()));
						}
						break;

					case "orgdownNm":
						if (dto != null) {
							dto.setSidoName(parser.nextText());
						}
						break;
					}
					break;
				}
				}
				eventType = parser.next();
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}*/

	@RequestMapping(value = "getSigungu")
	public @ResponseBody ArrayList<LocationDTO> getSigungu(@RequestParam("sidoCode") String sidoCode) {
		String addr = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/sigungu?upr_cd="
				+ sidoCode + "&ServiceKey=";
		String serviceKey = "XCdNWTVmXT3Zk0y%2BK3CpUAV2t4qBVGx34uevgRwA8jGhto%2FVOnbeSyfYnh74wEKL0DGPoql%2FDnZy6cjcbDGnHg%3D%3D";
		
		ArrayList<LocationDTO> list = null;
		LocationDTO dto = new LocationDTO();

		try {
			URL url = new URL(addr + serviceKey);

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			factory.setNamespaceAware(true);
			XmlPullParser parser = factory.newPullParser();
			BufferedInputStream bis = new BufferedInputStream(url.openStream());
			parser.setInput(bis, "utf-8");

			int eventType = parser.getEventType();

			while (eventType != XmlPullParser.END_DOCUMENT) {
				switch (eventType) {
				case XmlPullParser.END_DOCUMENT:
					break;
				case XmlPullParser.START_DOCUMENT:
					list = new ArrayList<LocationDTO>();
					break;
				case XmlPullParser.END_TAG: {
					String tag = parser.getName();
					if (tag.equals("item")) {
						list.add(dto);
						dto = null;
					}
				}
				case XmlPullParser.START_TAG: {
					String tag = parser.getName();
					switch (tag) {
					case "item":
						dto = new LocationDTO();
						break;

					case "orgCd":
						if (dto != null) {
							dto.setSigundoCode(Integer.parseInt(parser.nextText()));
						}
						break;

					case "orgdownNm":
						if (dto != null) {
							dto.setSigundoName(parser.nextText());
						}
						break;
						
					case "uprCd":
						if (dto != null) {
							dto.setSidoCode(Integer.parseInt(parser.nextText()));
						}
						break;
					}
					break;
				}
				}
				eventType = parser.next();
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return list;
	}
	
	@RequestMapping(value = "getAnimalType")
	public @ResponseBody ArrayList<AnimalDTO> getAnimalType(@RequestParam("animalCode") String animalCode) {
		String addr = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/kind?up_kind_cd="+animalCode+"&ServiceKey=";
		String serviceKey = "XCdNWTVmXT3Zk0y%2BK3CpUAV2t4qBVGx34uevgRwA8jGhto%2FVOnbeSyfYnh74wEKL0DGPoql%2FDnZy6cjcbDGnHg%3D%3D";

		ArrayList<AnimalDTO> list = null;
		AnimalDTO dto = new AnimalDTO();
		
		System.out.println("동물 요청 : "+addr+serviceKey);

		try {
			URL url = new URL(addr + serviceKey);

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			factory.setNamespaceAware(true);
			XmlPullParser parser = factory.newPullParser();
			BufferedInputStream bis = new BufferedInputStream(url.openStream());
			parser.setInput(bis, "utf-8");

			int eventType = parser.getEventType();

			while (eventType != XmlPullParser.END_DOCUMENT) {
				switch (eventType) {
				case XmlPullParser.END_DOCUMENT:
					break;
				case XmlPullParser.START_DOCUMENT:
					list = new ArrayList<AnimalDTO>();
					break;
				case XmlPullParser.END_TAG: {
					String tag = parser.getName();
					if (tag.equals("item")) {
						list.add(dto);
						dto = null;
					}
				}
				case XmlPullParser.START_TAG: {
					String tag = parser.getName();
					switch (tag) {
					case "item":
						dto = new AnimalDTO();
						break;

					case "KNm":
						if (dto != null) {
							dto.setAnimalType(parser.nextText());
						}
						break;

					case "kindCd":
						if (dto != null) {
							dto.setAnimalCode(Integer.parseInt(parser.nextText()));
						}
						break;
					}
					break;
				}
				}
				eventType = parser.next();
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	@RequestMapping(value = "getShelter")
	public @ResponseBody ArrayList<ShelterDTO> getShelter(@RequestParam("sidoCode") String sidoCode, @RequestParam("sigundoCode") String sigundoCode) {
		String addr = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/shelter?upr_cd="+sidoCode+"&org_cd="+sigundoCode+"&ServiceKey=";
		String serviceKey = "XCdNWTVmXT3Zk0y%2BK3CpUAV2t4qBVGx34uevgRwA8jGhto%2FVOnbeSyfYnh74wEKL0DGPoql%2FDnZy6cjcbDGnHg%3D%3D";
		
		ArrayList<ShelterDTO> list = null;
		ShelterDTO dto = new ShelterDTO();

		try {
			URL url = new URL(addr + serviceKey);

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			factory.setNamespaceAware(true);
			XmlPullParser parser = factory.newPullParser();
			BufferedInputStream bis = new BufferedInputStream(url.openStream());
			parser.setInput(bis, "utf-8");

			int eventType = parser.getEventType();

			while (eventType != XmlPullParser.END_DOCUMENT) {
				switch (eventType) {
				case XmlPullParser.END_DOCUMENT:
					break;
				case XmlPullParser.START_DOCUMENT:
					list = new ArrayList<ShelterDTO>();
					break;
				case XmlPullParser.END_TAG: {
					String tag = parser.getName();
					if (tag.equals("item")) {
						list.add(dto);
						dto = null;
					}
				}
				case XmlPullParser.START_TAG: {
					String tag = parser.getName();
					switch (tag) {
					case "item":
						dto = new ShelterDTO();
						break;

					case "careNm":
						if (dto != null) {
							dto.setShelterName(parser.nextText());
						}
						break;

					case "careRegNo":
						if (dto != null) {
							dto.setShelterCode(parser.nextText());
						}
						break;
					}
					break;
				}
				}
				eventType = parser.next();
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	@RequestMapping(value = "shelterList")
	public @ResponseBody ArrayList<ShelterDTO> shelterList(@RequestParam ("sido") String sido, @RequestParam ("sigudo") String sigudo) {
		ArrayList<ShelterDTO> list = new ArrayList<ShelterDTO>();
		ShelterDTO shelter = null;
		
		/*for(ShelterDTO temp : shelterList) {
			if(!sido.equals("선택")) {
				if(temp.getLocationAddr().contains("서울특별시")) {
					shelter = temp;
					list.add(shelter);
				}
			}else {
				shelter = temp;
				list.add(shelter);
			}
		}*/
		return shelterList;
	}
	
	@RequestMapping(value = "shelterDetail")
	public @ResponseBody ShelterDTO shelterDetail(@RequestParam ("centetName") String name) {
		ShelterDTO shelter = null;
		for(ShelterDTO temp : shelterList) {
			if(temp.getCenterName().equals(name)) {
				shelter = temp;
			}
		}
		return shelter;
	}
		
	
}
