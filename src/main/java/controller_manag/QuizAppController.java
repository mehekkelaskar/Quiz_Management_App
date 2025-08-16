package controller_manag;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.bson.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import db_con.MongoConnectivity;
import email_verification.VerifyEmail;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import question.Question;

@Controller
public class QuizAppController {
	@Autowired
	VerifyEmail v;
	@Autowired
	MongoConnectivity mc;

	@GetMapping("/login")
	public String redirect(HttpServletRequest request, Model model) {

		HttpSession session = request.getSession(false); // false = don't create if not exists
		if (session != null && session.getAttribute("email") != null) {
			String email = (String) session.getAttribute("email");
			String username = (String) session.getAttribute("username");
			List<Document> count = mc.getAllTests();
			int totalTests = count.size();

			model.addAttribute("username", username);
			model.addAttribute("total_count", totalTests);

			if (mc.isAdminEmail(email)) {
				loadAdminDashboardData(model);
				return "adminPage";
			} else if (mc.isTeacher(email)) {
				return "testtakerPage";
			}
			return "userview"; // Student Dashboard
		}

		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			List<Document> count = mc.getAllTests();
			int totalTests = count.size();
			for (Cookie cookie : cookies) {
				if ("remember_token".equals(cookie.getName())) {
					String token = cookie.getValue();
					String email = mc.findEmailByToken(token); // Get email using token

					if (email != null) {
						String username = mc.getUsernameByEmail(email); // <-- implement this in DAO

						session = request.getSession(true);
						session.setAttribute("email", email);
						session.setAttribute("username", username);

						model.addAttribute("username", username);
						model.addAttribute("total_count", totalTests);

						if (mc.isAdminEmail(email)) {
							loadAdminDashboardData(model);
							return "adminPage";

						} else if (mc.isTeacher(email)) {
							return "testtakerPage";
						}

						return "userview"; 
					}
				}
			}
		}

		return "loginPage"; 
	}

	@PostMapping("/userData")
	public String sendOtp(@RequestParam("email") String email, HttpSession session,
			@RequestParam("username") String username) {
		try {
			v.receiverEmail(email);
			session.setAttribute("email", email);
			session.setAttribute("username", username);
			return "otpPage";
		} catch (Exception e) {
			return "errorPage";
		}

	}

	@PostMapping("/otpVerification")
	public String verifyOtp(@RequestParam("otp") int otp,
			@RequestParam(value = "remember", required = false) Boolean remember, HttpSession session,
			HttpServletResponse response, Model m) {

		if (v.verifyOtp(otp)) {
			String email = (String) session.getAttribute("email");
			String username = (String) session.getAttribute("username");
			Boolean isAdmin = mc.isAdminEmail(email);
			Boolean isTesttaker = mc.isTeacher(email);

			session.setAttribute("email", email);
			session.setAttribute("username", username);
			if (Boolean.TRUE.equals(remember)) {

				String token = UUID.randomUUID().toString();
				mc.saveToken(email, token);
				mc.saveEmail(email);
				Cookie cookie = new Cookie("remember_token", token);
				cookie.setHttpOnly(true);
				cookie.setPath("/");
				cookie.setMaxAge(7 * 24 * 60 * 60);
				cookie.setSecure(true); // Only if you’re using HTTPS

				response.addCookie(cookie);

			}
			if (isAdmin) {
				loadAdminDashboardData(m);
				return "adminPage";
			} else if (isTesttaker) {
				return "testtakerPage";
			}

			else {

				mc.saveUserIfNotExists(email);
				return "userview";
			}

		}

		return "errorPage";

	}

	public void loadAdminDashboardData(Model model) {
		int studentCount = mc.getStudentCount();
		int teacherCount = mc.getTeacherCount();
		int activeQuizzes = mc.getAllTests().size();

		model.addAttribute("studentCount", studentCount);
		model.addAttribute("teacherCount", teacherCount);
		model.addAttribute("activeQuizzes", activeQuizzes);
	}

	@GetMapping("/addFac")
	public String addFaculty() {
		return "addTeacher";
	}

	@ResponseBody
	@PostMapping("/addingFac")
	public String addedTeacher(@RequestParam("name") String name, @RequestParam("email") String email) {
		try {
			mc.saveTeachers(name, email);
			return "done";
		} catch (Exception e) {
			System.out.println(e);
		}
		return "notdone";

	}

	@GetMapping("/removeFac")
	public String removeFaculty() {
		return "removeTeacher";
	}

	@ResponseBody
	@PostMapping("/removingFac")
	public String removedTeacher(@RequestParam("email") String email) {
		try {
			mc.removeTeacher(email);
			return "done";
		} catch (Exception e) {
			System.out.println(e);
		}
		return "notdone";
	}

	@GetMapping("/fetchAllTeacher")
	public String fetchTeacher(Model model) {
		List<Document> teachers = mc.getAllTeachers(); // Call service method
		model.addAttribute("teachers", teachers); // Add to model
		return "allTeachers";
	}

	@GetMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
	    // Invalidate the HTTP session
	    HttpSession session = request.getSession(false);
	    if (session != null) {
	        session.invalidate();
	    }

	    // Expire the JSESSIONID cookie
	    Cookie cookie = new Cookie("JSESSIONID", null);
	    cookie.setMaxAge(0); // Delete the cookie
	    cookie.setPath("/"); // Set path so it matches the cookie path
	    response.addCookie(cookie);

	    return "redirect:/index.jsp";
	}

	

	@GetMapping("/fetchStudents")
	public String getStud(Model model) {

		List<Document> student = mc.getStudent();
		model.addAttribute("students", student);
		return "allStudents";
	}

	@GetMapping("/uploadTest")
	public String upload() {
		return "testPage";
	}
	@PostMapping("/submitQuestions")
	public String handleQuestionsSubmission(
	        @RequestParam("testName") String testName,
	        @RequestParam("duration") int testTime,
	        @RequestParam("expiryDate") String expiryDateStr,
	        @RequestParam("questionText") List<String> questionTexts,
	        @RequestParam("optionA") List<String> optionAs,
	        @RequestParam("optionB") List<String> optionBs,
	        @RequestParam("optionC") List<String> optionCs,
	        @RequestParam("optionD") List<String> optionDs,
	        @RequestParam("correctAnswer") List<String> correctAnswers) {

	    List<Question> questionList = new ArrayList<>();

	    for (int i = 0; i < questionTexts.size(); i++) {
	        Question q = new Question();
	        q.setQuestionText(questionTexts.get(i).trim());

	        List<String> options = new ArrayList<>();
	        options.add(optionAs.get(i).trim());
	        options.add(optionBs.get(i).trim());
	        options.add(optionCs.get(i).trim());
	        options.add(optionDs.get(i).trim());

	        q.setOptions(options);
	        q.setCorrectAnswer(correctAnswers.get(i).trim().toUpperCase());

	        questionList.add(q);
	    }

	    // Save the test with expiry date
	    mc.saveTest(testName.trim(), testTime, expiryDateStr.trim(), questionList);

	    return "addedQuestions";
	}



	@GetMapping("/totalQuiz")
	public ModelAndView userHome() {
		List<Document> tests = mc.getAllTests();
		ModelAndView m = new ModelAndView();
		m.addObject("tests", tests);// Fetch tests from DB
		m.setViewName("totalTest");
		return m;
	}

	@GetMapping("/startTest")
	public String startTest(@RequestParam("testName") String testName, HttpServletRequest request) {
	    Document test = mc.getTestByName(testName);
	    System.out.println(testName);

	    if (test != null) {
	        List<Document> questions = (List<Document>) test.get("questions");
	        Integer duration = test.getInteger("duration");

	        request.setAttribute("questions", questions);
	        request.setAttribute("testName", testName);
	        request.setAttribute("duration", duration);

	        return "giveTest";
	    } else {
	        request.setAttribute("error", "Test not found!");
	        return "errorPage";
	    }
	}
	@PostMapping("/submitTest")
	public String submitTest(HttpServletRequest request, HttpSession session, Model model) {
	    String testName = request.getParameter("testName");
	    Document test = mc.getTestByName(testName);
	    if (test == null) {
	        model.addAttribute("error", "Test not found for name: " + testName);
	        return "errorPage";
	    }
	    List<Document> questions = (List<Document>) test.get("questions");

	    int score = 0;
	    int correctCount = 0;
	    int incorrectCount = 0;
	    int unattemptedCount = 0;

	    for (int i = 0; i < questions.size(); i++) {
	        String userAnswer = request.getParameter("q" + i);
	        Document question = questions.get(i);
	        String correctAnswer = question.getString("correctAnswer");

	        if (userAnswer != null) {
	            if (userAnswer.equalsIgnoreCase(correctAnswer)) {
	                score += 1;
	                correctCount++;
	            } else {
	                incorrectCount++;
	            }
	        } else {
	            unattemptedCount++;
	        }
	    }

	    // Store result in database
	    String email = (String) session.getAttribute("email");

	    Document resultDoc = new Document();
	    resultDoc.append("email", email);
	    resultDoc.append("testName", testName);
	    resultDoc.append("score", score);
	    resultDoc.append("correctCount", correctCount);
	    resultDoc.append("incorrectCount", incorrectCount);
	    resultDoc.append("unattemptedCount", unattemptedCount);
	    resultDoc.append("total", questions.size());
	    resultDoc.append("timestamp", new Date());

	    mc.saveResult(resultDoc); // Save to MongoDB

	    // Pass result to UI
	    model.addAttribute("score", score);
	    model.addAttribute("totalQuestions", questions.size());
	    model.addAttribute("correctCount", correctCount);
	    model.addAttribute("incorrectCount", incorrectCount);
	    model.addAttribute("unattemptedCount", unattemptedCount);

	    return "testResult";
	}


	@GetMapping("/totaltests")
	public String getTotalTests(Model model) {
		List<Document> total = mc.getAllTests();
		model.addAttribute("total", total);
		return "totaltest";

	}

	@GetMapping("/performance")
	public String showPerformance(HttpServletRequest request, HttpSession session) {
		String email = (String) session.getAttribute("email");

		List<Document> results = mc.getUserTestResults(email); // Fetch all test results of user
		List<Map<String, Object>> performanceData = new ArrayList<>();
		int previousScore = -1;

		for (Document doc : results) {
			int score = doc.getInteger("score");
			int total = doc.getInteger("total");
			Date timestamp = doc.getDate("timestamp");
			String testName = doc.getString("testName");

			double improvement = 0.0;
			if (previousScore != -1) {
				improvement = ((double) (score - previousScore) / total) * 100;
			}
			previousScore = score;

			Map<String, Object> row = new HashMap<>();
			row.put("testName", testName);
			row.put("score", score);
			row.put("total", total);
			row.put("timestamp", timestamp);
			row.put("improvement", String.format("%.2f", improvement));

			performanceData.add(row);
		}

		request.setAttribute("performanceData", performanceData);
		return "performancePage"; // JSP page to display performance
	}

	@GetMapping("/studentsPerformance")
	public String viewPerformance(Model model) {
	    List<Document> testResults = mc.getAllTestResults();
	    model.addAttribute("testResults", testResults);
	    return "allStudentsPerformance"; 
	}


}
