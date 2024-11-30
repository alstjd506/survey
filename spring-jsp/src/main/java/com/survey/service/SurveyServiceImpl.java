package com.survey.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.survey.mapper.SurveyMapper;
import com.survey.vo.SurveyVO;

@Service
public class SurveyServiceImpl implements SurveyService {
	
	@Autowired
	SurveyMapper mapper;
	
	@Override
	public List<SurveyVO> surveyList(Criteria criteria) {
		// TODO Auto-generated method stub
		return mapper.surveyList(criteria);
	}

	@Override
	public int getTotalCount(Criteria criteria) {
		// TODO Auto-generated method stub
		return mapper.getTotalCount(criteria);
	}

}
