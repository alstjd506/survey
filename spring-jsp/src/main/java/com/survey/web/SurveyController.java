package com.survey.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.survey.service.PageDTO;
import com.survey.service.Criteria;
import com.survey.service.SurveyService;
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
	public String surveyPost(SurveyVO surveyVO, Model model, HttpSession session) {
		
		return "survey/surveyPost";
	}
}
