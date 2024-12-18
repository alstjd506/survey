package com.survey.service;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class Criteria {
	private int pageNum; 			// 현재 페이지
	private int amount; 			// 페이지 당 출력 데이터 수
	private String searchType; 		// 검색 키워드
	private String keyword; 		// 검색 유형 ex) 전체, 제목, 작성자 등
	private String startDate; 		// 검색 시작 날짜
	private String endDate; 		// 검색 종료 날짜
	
	private Integer userId;
	private Integer surveyId;
	
	private String finishStartDate;
	private String finishEndDate;

	public Criteria() {
		this(1, 5);
	}

	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
