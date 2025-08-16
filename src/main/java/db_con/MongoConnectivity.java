package db_con;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

import org.bson.Document;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;
import org.springframework.stereotype.Component;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Sorts;

import question.Question;

@Component
public class MongoConnectivity {

	private MongoCollection<Document> adminCollection;
	private MongoCollection<Document> userCollection;
	private MongoCollection<Document> tokenCollection;
	private MongoCollection<Document> testtakerCollection;
	private MongoCollection<Document> testCollection;
	private MongoCollection<Document> testresultCollection;

	public MongoConnectivity() {
		String uri = "mongodb+srv://waste_management:SyA14iRjLjlEVzQc@management.lnf5snl.mongodb.net/?retryWrites=true&w=majority&appName=management";
		MongoClient mongoClient = MongoClients.create(uri);
		MongoDatabase database = mongoClient.getDatabase("quizportal");

		adminCollection = database.getCollection("admin");
		userCollection = database.getCollection("users");
		tokenCollection = database.getCollection("remember_token");
		testtakerCollection = database.getCollection("testtaker");
		testCollection = database.getCollection("test");
		testresultCollection=database.getCollection("testresult");
	}

	public boolean isAdminEmail(String email) {
		Document doc = new Document("email", email);
		Document d = adminCollection.find(doc).first();
		return d != null;
	}

	public void saveUserIfNotExists(String email) {
		Document doc = new Document("email", email);
		Document existing = userCollection.find(doc).first();
		if (existing == null) {
			userCollection.insertOne(doc);
		}
		
	}public String getUsernameByEmail(String email) {
	    MongoCollection<Document> collection = userCollection;
	    Document user = collection.find(new Document("email", email)).first();
	    if (user != null) {
	        return user.getString("username");
	    }
	    return null;
	}

	


	public void saveToken(String email, String token) {
		Document doc = new Document("email", email).append("token", token).append("expiry",
				new Date(System.currentTimeMillis() + 7L * 24 * 60 * 60 * 1000)); // 7 days
		tokenCollection.insertOne(doc);
	}

	public void saveEmail(String email) {
		Document d = new Document("email", email);
		userCollection.insertOne(d);

	}
	/*
	 * public void getUsername(String email) { Document doc = new Document("email",
	 * email); Document d=userCollection.find(doc)
	 * 
	 * }
	 */

	public void saveTeachers(String name, String email) {
		Document d = new Document("name", name).append("email", email);
		testtakerCollection.insertOne(d);

	}

	public void removeTeacher(String email) {

		testtakerCollection.deleteOne(Filters.eq("email", email));

	}

	public List<Document> getAllTeachers() {
		List<Document> teacherList = new ArrayList<>();
		FindIterable<Document> documents = testtakerCollection.find();

		for (Document doc : documents) {
			teacherList.add(doc);
		}
		return teacherList;
	}

	// 🔹 Get email back from token
	public String findEmailByToken(String token) {
		Document doc = tokenCollection.find(Filters.eq("token", token)).first();
		if (doc != null && doc.getDate("expiry").after(new Date())) {
			return doc.getString("email");
		}
		return null;
	}

	public List<Document> getStudent() {
		ArrayList<Document> student_list = new ArrayList<>();
		FindIterable<Document> f = userCollection.find();
		for (Document d : f) {
			student_list.add(d);
		}
		return student_list;
	}

	public boolean isTeacher(String email) {
		Document doc = new Document("email", email);
		Document d = testtakerCollection.find(doc).first();
		return d != null;
	}
	public int getStudentCount() {
	    return (int) userCollection.countDocuments();
	}

	public int getTeacherCount() {
	    return (int) testtakerCollection.countDocuments();
	}

	public void saveTest(String testName, int duration, String expiryDateStr, List<Question> questions) {
	    Document testDoc = new Document("testName", testName.trim())
	                            .append("duration", duration)
	                            .append("expiryDate", expiryDateStr); // add expiry date here

	    List<Document> questionDocs = new ArrayList<>();
	    for (Question q : questions) {
	        Document qDoc = new Document("questionText", q.getQuestionText())
	                            .append("options", q.getOptions())
	                            .append("correctAnswer", q.getCorrectAnswer());
	        questionDocs.add(qDoc);
	    }

	    testDoc.append("questions", questionDocs);

	    testCollection.insertOne(testDoc);
	}




	public List<Document> getAllTests() {
	    List<Document> testList = new ArrayList<>();
	    FindIterable<Document> documents = testCollection.find();
	    for (Document doc : documents) {
	        testList.add(doc);
	    }
	    return testList;
	}
	public Document getTestByName(String testName) {
	    Bson filter = Filters.eq("testName", testName);  // Simple direct equality
	    return testCollection.find(filter).first();
	}




	public void debugPrintAllTests() {
	    FindIterable<Document> tests = testCollection.find();
	    for (Document doc : tests) {
	        System.out.println("Stored Test Document: " + doc.toJson());
	    }
	}

	public void saveResult(Document resultDoc) {
	     testresultCollection.insertOne(resultDoc);
	 
	}
	//FOR STUDENTS TO CHECK THEIR PERFORMANCE
	public List<Document> getUserTestResults(String email) {
	    List<Document> results = new ArrayList<>();
	    
	    FindIterable<Document> documents = testresultCollection.find(Filters.eq("email", email))
	                                            .sort(Sorts.ascending("timestamp"));
	    
	    for (Document doc : documents) {
	        results.add(doc);
	    }
	    return results;
	}
	//FOR ADMIN TO FETCH THE PERFORMACE OF STUDENTS 
	public List<Document> getAllTestResults() {
	    List<Document> results = new ArrayList<>();
	    FindIterable<Document> documents = testresultCollection.find().sort(Sorts.descending("timestamp"));
	    for (Document doc : documents) {
	        results.add(doc);
	    }
	    return results;
	}


	




	// 🔹 Delete tokens when logging out
//    public void deleteTokenByEmail(String email) {
//        tokenCollection.deleteMany(Filters.eq("email", email));
//    }
}
