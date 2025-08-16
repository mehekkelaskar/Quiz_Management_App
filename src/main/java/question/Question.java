package question;

import java.util.ArrayList;
import java.util.List;

public class Question {

	    private String questionText;
	    private List<String> options = new ArrayList<>();
	    private String correctAnswer;

	    public Question() {
	    }

	    public String getQuestionText() {
	        return questionText;
	    }

	    public void setQuestionText(String questionText) {
	        this.questionText = questionText;
	    }

	    public List<String> getOptions() {
	        return options;
	    }

	    public void setOptions(List<String> options) {
	        this.options = options;
	    }

	    public void addOption(String option) {
	        this.options.add(option);
	    }

	    public String getCorrectAnswer() {
	        return correctAnswer;
	    }

	    public void setCorrectAnswer(String correctAnswer) {
	        this.correctAnswer = correctAnswer;
	    }
	}

	 
