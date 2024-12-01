package com.survey.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.survey.service.PageDTO;
import com.survey.service.Criteria;
import com.survey.service.SurveyService;
import com.survey.vo.AnswerVO;
import com.survey.vo.OptionVO;
import com.survey.vo.QuestionVO;
import com.survey.vo.SurveyVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class SurveyController {
	private static final Logger logger = LoggerFactory.getLogger(SurveyController.class);

	@Autowired
	SurveyService ssvc;

	@GetMapping("/survey/surveyList.do")
	public String surveyList(SurveyVO surveyVO, Criteria criteria, Model model) {
		logger.debug("Entering surveyList method");
		// 로직
		logger.info("Returning surveyList view");
		List<SurveyVO> list = ssvc.surveyList(criteria);
		int totalCount = ssvc.getTotalCount(criteria);

		PageDTO pageDTO = new PageDTO(10, totalCount, criteria);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("criteria", criteria);
		model.addAttribute("surveyList", list);

		return "survey/surveyList";
	}

	@GetMapping("/survey/surveyPost.do")
	public String surveyPost(@RequestParam("surveyId") int surveyId, SurveyVO surveyVO, Model model,
			HttpSession session) {
		System.out.println("Survey ID: " + surveyId); // 디버깅 로그 추가
		surveyVO.setSurveyId(surveyId);
		SurveyVO surveyPost = ssvc.surveyPost(surveyVO);

		model.addAttribute("surveyPost", surveyPost);
		return "survey/surveyPost";
	}

	@GetMapping("/survey/questionPost.do")
	public String getQuestionPost(QuestionVO questionVO, Criteria criteria, HttpSession session,
			@RequestParam int surveyId, Model model) {

		Integer userId = 1;

		criteria.setSurveyId(surveyId);
		criteria.setUserId(1);

		AnswerVO answerVO = new AnswerVO();
		answerVO.setUserId(1);
		answerVO.setSurveyId(surveyId);
		List<AnswerVO> alist = ssvc.getAnswerTextList(answerVO);
		List<QuestionVO> list = ssvc.getQuestionList(criteria);
		int totalCount = ssvc.getQuestionTotalCount(criteria);
		List<OptionVO> opList = ssvc.getOptionList(1, surveyId);
		int totalParentCount = ssvc.totalParentCount(criteria);

		int parentStartIndex = (criteria.getPageNum() - 1) * criteria.getAmount() + 1;
		int parentIndex = parentStartIndex;

		for (QuestionVO question : list) {
			if (question.getQuestionLevel() == 1) {
				question.setIndex(parentIndex++);
			} else {
				question.setIndex(null);
			}
		}
		
		
		PageDTO pageDTO = new PageDTO(1, totalCount, criteria);

		model.addAttribute("totalParentCount", totalParentCount);
		model.addAttribute("option", opList);
		model.addAttribute("survey", surveyId);
		model.addAttribute("pageDTO", pageDTO);
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("question", list);
		model.addAttribute("answerText", alist);
		return "survey/questionPost";

	}
}
