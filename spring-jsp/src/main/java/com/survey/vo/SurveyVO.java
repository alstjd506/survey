package com.survey.vo;

import java.util.Date;

import lombok.Data;

@Data
public class SurveyVO {
	private Integer surveyId;
	private String title;
	private String content;
	private Date startDt;
	private Date endDt;
	private String status;
	private Date createDt;
	private Date updateDt;
	private Integer userId;
	private Integer questionId;
		
	private String name;
}
