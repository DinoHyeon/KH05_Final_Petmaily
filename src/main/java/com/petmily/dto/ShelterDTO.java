package com.petmily.dto;

public class ShelterDTO {
	private String shelterCode;
	private String shelterName;
	private String centerName;//동물보호센터 명
	private String manageName;//관리기관 명
	private String centerType;//센터유형
	private String roadAddr;//소재지 도로명 주소
	private String locationAddr;//소재지 지번 주소
	private String x;//위도
	private String y;//경도
	private String weekdayStartTime;//평일 운영 시작
	private String weekdayEndTime;//평일 운영 종료
	private String weekendStartTime;//주말 운영 시작
	private String weekendEndTime;//주말 운영 종료
	private String holiday;//휴무일
	private String phoneNum;//전화번호
	
	
	
	public String getShelterCode() {
		return shelterCode;
	}
	public String getShelterName() {
		return shelterName;
	}
	public void setShelterCode(String shelterCode) {
		this.shelterCode = shelterCode;
	}
	public void setShelterName(String shelterName) {
		this.shelterName = shelterName;
	}
	public String getCenterName() {
		return centerName;
	}
	public void setCenterName(String centerName) {
		this.centerName = centerName;
	}
	public String getManageName() {
		return manageName;
	}
	public void setManageName(String manageName) {
		this.manageName = manageName;
	}
	public String getCenterType() {
		return centerType;
	}
	public void setCenterType(String centerType) {
		this.centerType = centerType;
	}
	public String getRoadAddr() {
		return roadAddr;
	}
	public void setRoadAddr(String roadAddr) {
		this.roadAddr = roadAddr;
	}
	public String getLocationAddr() {
		return locationAddr;
	}
	public void setLocationAddr(String locationAddr) {
		this.locationAddr = locationAddr;
	}
	public String getX() {
		return x;
	}
	public void setX(String x) {
		this.x = x;
	}
	public String getY() {
		return y;
	}
	public void setY(String y) {
		this.y = y;
	}
	public String getWeekdayStartTime() {
		return weekdayStartTime;
	}
	public void setWeekdayStartTime(String weekdayStartTime) {
		this.weekdayStartTime = weekdayStartTime;
	}
	public String getWeekdayEndTime() {
		return weekdayEndTime;
	}
	public void setWeekdayEndTime(String weekdayEndTime) {
		this.weekdayEndTime = weekdayEndTime;
	}
	public String getWeekendStartTime() {
		return weekendStartTime;
	}
	public void setWeekendStartTime(String weekendStartTime) {
		this.weekendStartTime = weekendStartTime;
	}
	public String getWeekendEndTime() {
		return weekendEndTime;
	}
	public void setWeekendEndTime(String weekendEndTime) {
		this.weekendEndTime = weekendEndTime;
	}
	public String getHoliday() {
		return holiday;
	}
	public void setHoliday(String holiday) {
		this.holiday = holiday;
	}
	public String getPhoneNum() {
		return phoneNum;
	}
	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}
	
	
	
	
}
