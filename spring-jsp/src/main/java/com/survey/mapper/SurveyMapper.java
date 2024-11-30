package com.survey.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.survey.service.Criteria;
import com.survey.vo.SurveyVO;

@Mapper
public interface SurveyMapper {

	List<SurveyVO> surveyList(Criteria criteria);
	public int getTotalCount(Criteria criteria);
}
