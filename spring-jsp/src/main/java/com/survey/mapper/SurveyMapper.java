package com.survey.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.survey.service.Criteria;
import com.survey.vo.AnswerVO;
import com.survey.vo.OptionVO;
import com.survey.vo.QuestionVO;
import com.survey.vo.SurveyVO;

@Mapper
public interface SurveyMapper {

	List<SurveyVO> surveyList(Criteria criteria);
	public int getTotalCount(Criteria criteria);
	public SurveyVO surveyPost(SurveyVO surveyVO);


	List<OptionVO> getOptionList(@Param("userId") int userId, @Param("surveyId") int surveyId);
	List<QuestionVO> getQuestionList(Criteria criteria);
	List<AnswerVO> getAnswerTextList(AnswerVO answerVO);

	public int getQuestionTotalCount(Criteria criteria);
	public int totalParentCount(Criteria criteria);
	
	List<QuestionVO> parentNumber(@Param("surveyId") int surveyId);
	
	public int insAnswer(AnswerVO answerVO);
	public int delAnswer(AnswerVO answerVO);
	public int clearSelections(AnswerVO answerVO);
	
	public Integer getAnswerId(AnswerVO answerVO);
}
