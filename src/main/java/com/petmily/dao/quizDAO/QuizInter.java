package com.petmily.dao.quizDAO;

import java.util.ArrayList;

import com.petmily.dto.QuizDTO;

public interface QuizInter {

	ArrayList<String> getAnimalList();

	int registQuiz(QuizDTO dto);

	ArrayList<QuizDTO> getQuizList();

	QuizDTO quizDetail(int parseInt);

	QuizDTO quizUpdateView(int parseInt);

	int quizUpdate(QuizDTO dto);

	int quizDelete(int idx);

}
