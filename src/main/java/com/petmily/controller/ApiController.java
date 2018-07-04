package com.petmily.controller;

import java.io.BufferedInputStream;
import java.net.URL;
import java.util.ArrayList;

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
	@RequestMapping(value = "apiPage")
	public String apiPage() {
		return "getApi";
	}
	

	@RequestMapping(value = "getSido")
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
	}

	@RequestMapping(value = "getSigungu")
	public @ResponseBody ArrayList<LocationDTO> getSigungu(@RequestParam("sidoCode") String sidoCode) {
		String addr = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/sigungu?upr_cd="
				+ sidoCode + "&ServiceKey=";
		String serviceKey = "XCdNWTVmXT3Zk0y%2BK3CpUAV2t4qBVGx34uevgRwA8jGhto%2FVOnbeSyfYnh74wEKL0DGPoql%2FDnZy6cjcbDGnHg%3D%3D";

		System.out.println(addr+serviceKey);
		
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
}
