package email_verification;

import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.springframework.stereotype.Component;
import controller_manag.QuizAppController;

@Component
public class VerifyEmail {
	QuizAppController q=new QuizAppController();
int otp;
	 private  int generateOTP() {
         Random random = new Random();
         int otp = 100000 + random.nextInt(900000);
         return otp;
     }
	
	public void receiverEmail(String to) {
	String from="piku12642@gmail.com";
	 otp=generateOTP();
	
	String subject="OTP VERIFICATION";
	sendEmail(subject,otp,from,to);
	}
	
 private void sendEmail(String subject,int otp,String from,String to) { 
	 Properties prop=new Properties();
	 prop.put("mail.smtp.host", "smtp.gmail.com");
	 prop.put("mail.smtp.port", "465");
	 prop.put("mail.smtp.ssl.enable", "true");
	 prop.put("mail.smtp.auth", "true");
	 prop.put("mail.smtp.socketFactory.port", "465");
	 prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	 prop.put("mail.smtp.socketFactory.fallback", "false");

	 Session s =Session.getInstance(prop,new Authenticator() {
		 public PasswordAuthentication getPasswordAuthentication() {
			 return  new PasswordAuthentication("piku12642@gmail.com", "notv bynq qyye dkjy");
			 
		 }
	 });
	 
	 
	 s.setDebug(true);
	 MimeMessage m=new MimeMessage(s);
	 try {
		m.setFrom(from);
		 m.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
		 m.setSubject(subject);
         m.setText("Your OTP is: " + otp);
         Transport.send(m);
         System.out.println("Sent success...");
	} catch (MessagingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

 }
	public boolean verifyOtp(int reciever_otp){
return (reciever_otp==this.otp);

}
	
	
}



