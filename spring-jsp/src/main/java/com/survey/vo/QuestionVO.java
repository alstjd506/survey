package com.survey.vo;

import lombok.Data;

@Data
public class QuestionVO {
	private Integer questionId;
	private String questionText;
	private Integer surveyId;
	private Integer questionType;
	private Integer parentQuestionId;
	private Integer turn;
	private Integer required;
	private Integer qCategoryId;
	private String qCategoryName;
	
	private String categoryName;
	private Integer categoryId;
	private Integer questionLevel;
	private Integer questionNum;
	
	private Integer questionIndex;
	private Integer index;
	private Integer childCount;
	
	public boolean isParent() {
        return parentQuestionId == null; 
    }
	
	public Integer getChildCount() {
	    return childCount != null ? childCount : 0; 
	}
}
