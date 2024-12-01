package com.survey.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.survey.mapper.SurveyMapper;
import com.survey.vo.AnswerVO;
import com.survey.vo.OptionVO;
import com.survey.vo.QuestionVO;
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

	@Override
	public SurveyVO surveyPost(SurveyVO surveyVO) {
		// TODO Auto-generated method stub
		return mapper.surveyPost(surveyVO);
	}


	@Override
	public List<QuestionVO> getQuestionList(Criteria criteria) {
		// TODO Auto-generated method stub
		return mapper.getQuestionList(criteria);
	}

	@Override
	public List<AnswerVO> getAnswerTextList(AnswerVO answerVO) {
		// TODO Auto-generated method stub
		return mapper.getAnswerTextList(answerVO);
	}

	@Override
	public List<OptionVO> getOptionList(int userId, int surveyId) {
		// TODO Auto-generated method stub
		return mapper.getOptionList(userId, surveyId);
	}

	@Override
	public int getQuestionTotalCount(Criteria criteria) {
		// TODO Auto-generated method stub
		return mapper.getQuestionTotalCount(criteria);
	}

	@Override
	public int totalParentCount(Criteria criteria) {
		// TODO Auto-generated method stub
		return mapper.totalParentCount(criteria);
	}

	@Override
	public List<QuestionVO> parentNumber(int surveyId) {
		// TODO Auto-generated method stub
		return mapper.parentNumber(surveyId);
	}

	@Override
	public void insAnswer(AnswerVO answerVO) {
		// TODO Auto-generated method stub
		mapper.insAnswer(answerVO);
	}

	@Override
	public void delAnswer(AnswerVO answerVO) {
		// TODO Auto-generated method stub
		int answerId = mapper.getAnswerId(answerVO);
		System.out.println(">>>>>>>>>>>>answerId"+ answerId);
		answerVO.setAnswerId(answerId);
		mapper.delAnswer(answerVO);
	}

	@Override
	public void clearSelections(AnswerVO answerVO) {
		// TODO Auto-generated method stub
		mapper.clearSelections(answerVO);
	}
	
	@Transactional
	@Override
	public void processAnswer(AnswerVO answerVO) {
		
		mapper.clearSelections(answerVO);
		mapper.insAnswer(answerVO);
		
	}

	

}
