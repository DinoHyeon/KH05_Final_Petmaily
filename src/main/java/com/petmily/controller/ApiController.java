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
import org.springframework.web.servlet.ModelAndView;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import com.petmily.dto.AnimalDTO;
import com.petmily.dto.LocationDTO;
import com.petmily.dto.NoticeDTO;
import com.petmily.dto.ShelterDTO;

@Controller
public class ApiController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	//////////////////////// 보네 - 메인페이지에서 사용//////////////////////////

	int mtotalCount = 1;// 분기별 유기동물 총 카운트
	int prot = 1;// 보호중
	int nDie = 0;// 종료(자연사)
	int ret = 0;// 종료(반환)
	int adpt = 0;// 종료(입양)
	int bDie = 0;// 종료(안락사)
	int give = 0;// 종료(기증)
	int netu = 0;// 종료(방사)
	int fullCnt = 1;// 동물상태 카운트 - 전체수
	// ArrayList<NoticeDTO> mainList = new ArrayList<NoticeDTO>();//메인페이지 유기동물 리스트
	HashMap<String, Integer> map = new HashMap<>();// 동물상태 담을 map

	//////////////////////////////////////////////////////////////////////////

	// 보호소 전체 리스트
	ArrayList<ShelterDTO> shelterList = new ArrayList<ShelterDTO>();

	// 메인페이지에서 상세보기로 연결하기위해 보네 같이사용
	ArrayList<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
	HashMap<String, String> noticeConditions = new HashMap<String, String>();
	int shelterListAllCnt = 0;

	@RequestMapping(value = "apiPage")
	public String apiPage() {
		return "getApi";
	}

	@RequestMapping(value = "searchShelter")
	public String searchShelter(HttpSession session) {
		if (shelterList.isEmpty()) {
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
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return "searchShelter";
	}

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
		String addr = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/kind?up_kind_cd="
				+ animalCode + "&ServiceKey=";
		String serviceKey = "XCdNWTVmXT3Zk0y%2BK3CpUAV2t4qBVGx34uevgRwA8jGhto%2FVOnbeSyfYnh74wEKL0DGPoql%2FDnZy6cjcbDGnHg%3D%3D";

		ArrayList<AnimalDTO> list = null;
		AnimalDTO dto = new AnimalDTO();

		System.out.println("동물 요청 : " + addr + serviceKey);

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
							dto.setAnimalCode(parser.nextText());
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
	public @ResponseBody ArrayList<ShelterDTO> getShelter(@RequestParam("sidoCode") String sidoCode,
			@RequestParam("sigundoCode") String sigundoCode) {
		String addr = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/shelter?upr_cd="
				+ sidoCode + "&org_cd=" + sigundoCode + "&ServiceKey=";
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

		System.out.println("결과 길이" + list.size());
		return list;
	}

	@RequestMapping(value = "shelterList")
	public @ResponseBody HashMap<String, Object> shelterList(@RequestParam("sido") String sido,
			@RequestParam("sigundo") String sigundo, @RequestParam("page") int page, HttpSession session) {

		System.out.println(sido + "/" + sigundo);
		HashMap<String, Object> map = new HashMap<String, Object>();
		ArrayList<ShelterDTO> list = new ArrayList<ShelterDTO>();
		ArrayList<ShelterDTO> tempList = new ArrayList<ShelterDTO>();
		ShelterDTO shelter = null;

		for (ShelterDTO temp : shelterList) {
			if (!sido.equals("선택")) {
				if (temp.getLocationAddr() != null) {
					if (temp.getLocationAddr().contains(sido + " " + sigundo)) {
						shelter = temp;
						tempList.add(shelter);
					}
				}
			} else {
				shelter = temp;
				tempList.add(shelter);
			}

			shelterListAllCnt = tempList.size();
		}

		int pageCnt = shelterListAllCnt % 5 > 0 ? Math.round(shelterListAllCnt / 5) + 1 : shelterListAllCnt / 5;
		if (page > pageCnt) {
			page = pageCnt;
		}

		int end = 5 * page - 1;
		int start = end - 5 + 1;

		if (shelterListAllCnt != 0) {
			if (end > shelterListAllCnt) {
				for (int i = start; i <= shelterListAllCnt - 1; i++) {
					list.add(tempList.get(i));
				}
			} else {
				for (int i = start; i <= end; i++) {
					list.add(tempList.get(i));
				}
			}
		}

		map.put("list", list);
		map.put("currPage", page);
		map.put("pageCnt", pageCnt);

		return map;
	}

	@RequestMapping(value = "shelterDetail")
	public @ResponseBody ShelterDTO shelterDetail(@RequestParam("centetName") String name) {
		ShelterDTO shelter = null;
		for (ShelterDTO temp : shelterList) {
			if (temp.getCenterName().equals(name)) {
				shelter = temp;
			}
		}
		return shelter;
	}

	// 유기동물 공고 페이지 이동
	@RequestMapping(value = "animalNotice")
	public String animalNotice() {
		return "animalNotice";
	}

	@RequestMapping(value = "noticeList")
	public @ResponseBody HashMap<String, Object> noticeList(@RequestParam HashMap<String, String> params) {
		noticeList.clear();

		String showPageNum = "";
		String start_date = "";
		String end_date = "";
		String sido = "";
		String sigundo = "";
		String shelter = "";
		String animal = "";
		String animalType = "";
		String statement = "";

		System.out.println("뷰에서 받은 날짜 " + params.get("start_date"));
		showPageNum = params.get("showPageNum");
		System.out.println("요청 페이지" + showPageNum);
		if (params.get("start_date") != null) {
			start_date = params.get("start_date");
		}
		System.out.println("시작 일" + start_date);
		if (params.get("end_date") != null) {
			end_date = params.get("end_date");
		}
		System.out.println("종료 일" + end_date);
		sido = params.get("sido");
		System.out.println(sido);
		sigundo = params.get("sigundo");
		System.out.println(sigundo);
		shelter = params.get("shelter");
		System.out.println(shelter);
		animal = params.get("animal");
		System.out.println(animal);
		animalType = params.get("animalType");
		System.out.println(animalType);
		statement = params.get("statement");
		System.out.println(statement);

		HashMap<String, Object> map = new HashMap<String, Object>();

		String numOfRows;
		String totalCount = null;

		String serviceKey = "XCdNWTVmXT3Zk0y%2BK3CpUAV2t4qBVGx34uevgRwA8jGhto%2FVOnbeSyfYnh74wEKL0DGPoql%2FDnZy6cjcbDGnHg%3D%3D";
		String addr = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?serviceKey="
				+ serviceKey + "&bgnde=" + start_date + "&endde=" + end_date + "&upkind=" + animal + "&kind="
				+ animalType + "&upr_cd=" + sido + "&org_cd=" + sigundo + "&care_reg_no=" + shelter + "&state="
				+ statement + "&pageNo=" + params.get("showPageNum") + "&startPage=" + 1 + "&numOfRows=" + 8
				+ "&pageSize=10";

		NoticeDTO dto = new NoticeDTO();

		try {
			URL url = new URL(addr);

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
					noticeList = new ArrayList<NoticeDTO>();
					break;
				case XmlPullParser.END_TAG: {
					String tag = parser.getName();
					if (tag.equals("item")) {
						noticeList.add(dto);
					}
				}
				case XmlPullParser.START_TAG: {

					String tag = parser.getName();
					switch (tag) {
					case "item":
						dto = new NoticeDTO();
						break;
					case "age":
						if (dto != null) {
							dto.setAge(parser.nextText());
						}
						break;
					case "careAddr":
						if (dto != null) {
							dto.setCareAddr(parser.nextText());
						}
						break;
					case "careNm":
						if (dto != null) {
							dto.setCareNm(parser.nextText());
						}
						break;
					case "careTel":
						if (dto != null) {
							dto.setCareTel(parser.nextText());
						}
						break;
					case "chargeNm":
						if (dto != null) {
							dto.setChargeNm(parser.nextText());
						}
						break;
					case "colorCd":
						if (dto != null) {
							dto.setColorCd(parser.nextText());
						}
						break;
					case "desertionNo":
						if (dto != null) {
							dto.setDesertionNo(parser.nextText());
						}
						break;
					case "filename":
						if (dto != null) {
							dto.setFileName(parser.nextText());
						}
						break;
					case "happenDt":
						if (dto != null) {
							dto.setHappenDt(parser.nextText());
						}
						break;
					case "happenPlace":
						if (dto != null) {
							dto.setHappenPlace(parser.nextText());
						}
						break;
					case "kindCd":
						if (dto != null) {
							dto.setKindCd(parser.nextText());
						}
						break;
					case "neuterYn":
						if (dto != null) {
							dto.setNeuterYn(parser.nextText());
						}
						break;
					case "noticeEdt":
						if (dto != null) {
							dto.setNoticeEdt(parser.nextText());
						}
						break;
					case "noticeNo":
						if (dto != null) {
							dto.setNoticeNo(parser.nextText());
						}
						break;
					case "noticeSdt":
						if (dto != null) {
							dto.setNoticeSdt(parser.nextText());
						}
						break;
					case "officetel":
						if (dto != null) {
							dto.setOfficetel(parser.nextText());
						}
						break;
					case "orgNm":
						if (dto != null) {
							dto.setOrgNm(parser.nextText());
						}
						break;
					case "specialMark":
						if (dto != null) {
							dto.setSpeciaMark(parser.nextText());
						}
						break;
					case "popfile":
						if (dto != null) {
							dto.setPopfile(parser.nextText());
						}
						break;
					case "processState":
						if (dto != null) {
							dto.setProcessState(parser.nextText());
						}
						break;
					case "sexCd":
						if (dto != null) {
							dto.setSexCd(parser.nextText());
						}
						break;
					case "weight":
						if (dto != null) {
							dto.setWeight(parser.nextText());
						}
						break;
					case "totalCount":
						totalCount = parser.nextText();
						break;
					}
					break;
				}
				}
				eventType = parser.next();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println(noticeList.size());
		int pageCnt = Integer.parseInt(totalCount) % 10 > 0 ? Math.round(Integer.parseInt(totalCount) / 10) + 1
				: Integer.parseInt(totalCount) / 10;

		map.put("list", noticeList);
		map.put("currPage", params.get("showPageNum"));
		map.put("pageCnt", pageCnt);

		return map;
	}

	@RequestMapping(value = "noticeDetail")
	public ModelAndView noticeDetail(@RequestParam("idx") String idx) {
		ModelAndView mav = new ModelAndView();
		NoticeDTO dto = null;
		for (NoticeDTO temp : noticeList) {
			if (temp.getNoticeNo().equals(idx)) {
				dto = temp;
			}
		}

		mav.setViewName("noticeDetail");
		mav.addObject("dto", dto);

		return mav;
	}

	////////////////////////////// 보네/////////////////////////////////////////

	// 보네 - 분기별 유기동물 수
	@RequestMapping(value = "getTotalCount")
	public @ResponseBody int getTotalCount(@RequestParam("bgnde") String bgnde, @RequestParam("endde") String endde) {
		logger.info("getTotalCount실행");
		String addr1 = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?bgnde=";
		String addr2 = "&endde=";
		String addr3 = "&ServiceKey=XCdNWTVmXT3Zk0y%2BK3CpUAV2t4qBVGx34uevgRwA8jGhto%2FVOnbeSyfYnh74wEKL0DGPoql%2FDnZy6cjcbDGnHg%3D%3D";
		try {
			URL url = new URL(addr1 + bgnde + addr2 + endde + addr3);
			logger.info("url:" + url);
			logger.info("시작일 : " + bgnde);
			logger.info("종료일 : " + endde);

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			factory.setNamespaceAware(true);
			XmlPullParser parser = factory.newPullParser();
			BufferedInputStream bis = new BufferedInputStream(url.openStream());
			parser.setInput(bis, "utf-8");

			int eventType = parser.getEventType();

			while (eventType != XmlPullParser.END_DOCUMENT) {
				switch (eventType) {
				case XmlPullParser.START_TAG: {
					String tag = parser.getName();
					switch (tag) {
					case "totalCount":
						mtotalCount = Integer.parseInt(parser.nextText());
						logger.info("totalCount" + mtotalCount);
						break;
					}
				}
				}
				eventType = parser.next();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mtotalCount;
	}

	// 보네 - 오늘기준 동물 상태 수치화
	@RequestMapping(value = "getAnimalCnt")
	public @ResponseBody HashMap<String, Integer> getAnimalCnt(@RequestParam("bgnde") String bgnde,
			@RequestParam("endde") String endde) {
		if (nDie == 0 && ret == 0 && adpt == 0 && bDie == 0 && give == 0 && netu == 0) {
			logger.info("getAnimalCnt실행");
			String addr1 = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?bgnde=";
			String addr2 = "&endde=";
			String addr3 = "&numOfRows=100000&ServiceKey=XCdNWTVmXT3Zk0y%2BK3CpUAV2t4qBVGx34uevgRwA8jGhto%2FVOnbeSyfYnh74wEKL0DGPoql%2FDnZy6cjcbDGnHg%3D%3D";

			try {
				URL url = new URL(addr1 + bgnde + addr2 + endde + addr3);
				logger.info("url:" + url);
				logger.info("시작일 : " + bgnde);
				logger.info("종료일 : " + endde);

				XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
				factory.setNamespaceAware(true);
				XmlPullParser parser = factory.newPullParser();
				BufferedInputStream bis = new BufferedInputStream(url.openStream());
				parser.setInput(bis, "utf-8");

				int eventType = parser.getEventType();

				while (eventType != XmlPullParser.END_DOCUMENT) {
					switch (eventType) {
					case XmlPullParser.START_TAG: {
						String tag = parser.getName();
						switch (tag) {
						case "processState":
							String processState = parser.nextText();
							if (processState.equals("종료(자연사)")) {
								nDie++;
							} else if (processState.equals("종료(반환)")) {
								ret++;
							} else if (processState.equals("종료(입양)")) {
								adpt++;
							} else if (processState.equals("종료(안락사)")) {
								bDie++;
							} else if (processState.equals("종료(기증)")) {
								give++;
							} else if (processState.equals("종료(방사)")) {
								netu++;
							}
							logger.info(processState);
							fullCnt++;
							logger.info("종료(자연사): " + nDie + " 종료(반환): " + ret + " 종료(입양): " + adpt + " 종료(안락사): "
									+ bDie + " 종료(기증): " + give + " 종료(방사): " + netu);
							break;
						}
					}
					}
					eventType = parser.next();
				}
				logger.info("종료(자연사): " + nDie + " 종료(반환): " + ret + " 종료(입양): " + adpt + " 종료(안락사): " + bDie
						+ " 종료(기증): " + give + " 종료(방사): " + netu);

				map.put("nDie", nDie);// 종료(자연사)
				map.put("ret", ret);// 종료(반환)
				map.put("adpt", adpt);// 종료(입양)
				map.put("bDie", bDie);// 종료(안락사)
				map.put("give", give);// 종료(기증)
				map.put("netu", netu);// 종료(방사)
			} catch (Exception e) {
				e.printStackTrace();
			}
			return map;
		}
		return map;
	}

	// 보네 - 분기별 유기동물 수
	@RequestMapping(value = "getFindHome")
	public @ResponseBody int getFindHome(@RequestParam("bgnde") String bgnde, @RequestParam("endde") String endde) {
		if (prot == 0) {
			logger.info("getFindHome실행");
			String addr1 = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?bgnde=";
			String addr2 = "&endde=";
			String addr3 = "&numOfRows=100000&ServiceKey=XCdNWTVmXT3Zk0y%2BK3CpUAV2t4qBVGx34uevgRwA8jGhto%2FVOnbeSyfYnh74wEKL0DGPoql%2FDnZy6cjcbDGnHg%3D%3D";

			try {
				URL url = new URL(addr1 + bgnde + addr2 + endde + addr3);
				logger.info("url:" + url);
				logger.info("시작일 : " + bgnde);
				logger.info("종료일 : " + endde);

				XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
				factory.setNamespaceAware(true);
				XmlPullParser parser = factory.newPullParser();
				BufferedInputStream bis = new BufferedInputStream(url.openStream());
				parser.setInput(bis, "utf-8");

				int eventType = parser.getEventType();

				while (eventType != XmlPullParser.END_DOCUMENT) {
					switch (eventType) {

					case XmlPullParser.START_TAG: {
						String tag = parser.getName();
						switch (tag) {
						case "processState":
							String processState = parser.nextText();
							if (processState.equals("보호중")) {
								prot++;
							}
							logger.info("보호중 : " + prot);
							break;
						}
					}
					}
					eventType = parser.next();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return prot;
		}
		logger.info("getFindHome끝");
		return prot;
	}

	// 보네 - 메인리스트
	@RequestMapping(value = "getMainList")
	public @ResponseBody HashMap<String, Object> getMainList(@RequestParam("bgnde") String bgnde,
			@RequestParam("endde") String endde, @RequestParam("showPageNum") String showPageNum) {
		noticeList.clear();

		HashMap<String, Object> map = new HashMap<String, Object>();

		// String numOfRows;
		String totalCount = null;

		String addr1 = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?bgnde=";
		String addr2 = "&endde=";
		String addr3 = "&pageNo=";
		String addr4 = "&numOfRows=5&ServiceKey=XCdNWTVmXT3Zk0y%2BK3CpUAV2t4qBVGx34uevgRwA8jGhto%2FVOnbeSyfYnh74wEKL0DGPoql%2FDnZy6cjcbDGnHg%3D%3D";

		NoticeDTO NoticeDTO = new NoticeDTO();

		try {
			URL url = new URL(addr1 + bgnde + addr2 + endde + addr3 + showPageNum + addr4);

			XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
			factory.setNamespaceAware(true);
			XmlPullParser parser = factory.newPullParser();
			BufferedInputStream bis = new BufferedInputStream(url.openStream());
			parser.setInput(bis, "utf-8");

			int eventType = parser.getEventType();

			while (eventType != XmlPullParser.END_DOCUMENT) {
				switch (eventType) {
				case XmlPullParser.START_DOCUMENT:
					noticeList = new ArrayList<NoticeDTO>();
					break;
				case XmlPullParser.END_TAG: {
					String tag = parser.getName();
					if (tag.equals("item")) {
						noticeList.add(NoticeDTO);
					}
				}
				case XmlPullParser.START_TAG: {

					String tag = parser.getName();
					switch (tag) {
					case "item":
						NoticeDTO = new NoticeDTO();
						break;
					case "age":
						if (NoticeDTO != null) {
							NoticeDTO.setAge(parser.nextText());
						}
						break;
					case "careAddr":
						if (NoticeDTO != null) {
							NoticeDTO.setCareAddr(parser.nextText());
						}
						break;
					case "careNm":
						if (NoticeDTO != null) {
							NoticeDTO.setCareNm(parser.nextText());
						}
						break;
					case "careTel":
						if (NoticeDTO != null) {
							NoticeDTO.setCareTel(parser.nextText());
						}
						break;
					case "chargeNm":
						if (NoticeDTO != null) {
							NoticeDTO.setChargeNm(parser.nextText());
						}
						break;
					case "colorCd":
						if (NoticeDTO != null) {
							NoticeDTO.setColorCd(parser.nextText());
						}
						break;
					case "desertionNo":
						if (NoticeDTO != null) {
							NoticeDTO.setDesertionNo(parser.nextText());
						}
						break;
					case "filename":
						if (NoticeDTO != null) {
							NoticeDTO.setFileName(parser.nextText());
						}
						break;
					case "happenDt":
						if (NoticeDTO != null) {
							NoticeDTO.setHappenDt(parser.nextText());
						}
						break;
					case "happenPlace":
						if (NoticeDTO != null) {
							NoticeDTO.setHappenPlace(parser.nextText());
						}
						break;
					case "kindCd":
						if (NoticeDTO != null) {
							NoticeDTO.setKindCd(parser.nextText());
						}
						break;
					case "neuterYn":
						if (NoticeDTO != null) {
							NoticeDTO.setNeuterYn(parser.nextText());
						}
						break;
					case "noticeEdt":
						if (NoticeDTO != null) {
							NoticeDTO.setNoticeEdt(parser.nextText());
						}
						break;
					case "noticeNo":
						if (NoticeDTO != null) {
							NoticeDTO.setNoticeNo(parser.nextText());
						}
						break;
					case "noticeSdt":
						if (NoticeDTO != null) {
							NoticeDTO.setNoticeSdt(parser.nextText());
						}
						break;
					case "officetel":
						if (NoticeDTO != null) {
							NoticeDTO.setOfficetel(parser.nextText());
						}
						break;
					case "orgNm":
						if (NoticeDTO != null) {
							NoticeDTO.setOrgNm(parser.nextText());
						}
						break;
					case "speciaMark":
						if (NoticeDTO != null) {
							NoticeDTO.setSpeciaMark(parser.nextText());
						}
						break;
					case "popfile":
						if (NoticeDTO != null) {
							NoticeDTO.setPopfile(parser.nextText());
						}
						break;
					case "processState":
						if (NoticeDTO != null) {
							NoticeDTO.setProcessState(parser.nextText());
						}
						break;
					case "sexCd":
						if (NoticeDTO != null) {
							NoticeDTO.setSexCd(parser.nextText());
						}
						break;
					case "weight":
						if (NoticeDTO != null) {
							NoticeDTO.setWeight(parser.nextText());
						}
						break;
					case "totalCount":
						totalCount = parser.nextText();
						break;
					}
					break;
				}
				}
				eventType = parser.next();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		int pageCnt = Integer.parseInt(totalCount) % 10 > 0 ? Math.round(Integer.parseInt(totalCount) / 10) + 1
				: Integer.parseInt(totalCount) / 10;
		map.put("list", noticeList);
		map.put("currPage", showPageNum);
		map.put("pageCnt", pageCnt);
		return map;
	}

}