package com.survey.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ResponseVO {
	private Integer responseId;
	private Date submitId;
	private Integer surveyId;
	private Integer userId;
}
