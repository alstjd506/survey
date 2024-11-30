package com.survey.service;

import java.util.List;

import com.survey.vo.SurveyVO;

public interface SurveyService {
	List<SurveyVO> surveyList(Criteria criteria);
	public int getTotalCount(Criteria criteria);
}
