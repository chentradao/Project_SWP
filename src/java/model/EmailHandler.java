/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.naming.InitialContext;
import javax.naming.NamingException;

/**
 *
 * @author hailt
 */
public class EmailHandler {

    public static void sendEmail(String toEmail, String subject, String text) throws AddressException {
        try {
            String fromEmail = (String) new InitialContext().lookup("java:comp/env/email");
            String password = (String) new InitialContext().lookup("java:comp/env/password");
            Properties prop = System.getProperties();
            prop.put("mail.smtp.host", "smtp.gmail.com");
            prop.put("mail.smtp.port", "587");
            prop.put("mail.smtp.auth", "true");
            prop.put("mail.smtp.starttls.enable", "true");
            Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            Message mess = new MimeMessage(session);
            mess.setFrom(new InternetAddress(fromEmail));
            if (toEmail == null || toEmail.trim().isEmpty()) {
                toEmail ="nguyenxuanhanh0110@gmail.com";
            }
            mess.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            try {
                mess.setSubject(MimeUtility.encodeText(subject, "UTF-8", null));
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(EmailHandler.class.getName()).log(Level.SEVERE, null, ex);
            }

            mess.setText(text);
            mess.setContent(text, "text/html;charset=UTF-8");
            Transport.send(mess);

        } catch (NamingException ex) {
            Logger.getLogger(EmailHandler.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            Logger.getLogger(EmailHandler.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    
    // Thêm phương thức mới để gửi email xác nhận liên hệ
    public static void sendContactConfirmationEmail(String toEmail, String name, String subject, String message) throws AddressException, MessagingException {
        try {
            String fromEmail = (String) new InitialContext().lookup("java:comp/env/email");
            String password = (String) new InitialContext().lookup("java:comp/env/password");
            Properties prop = System.getProperties();
            prop.put("mail.smtp.host", "smtp.gmail.com");
            prop.put("mail.smtp.port", "587");
            prop.put("mail.smtp.auth", "true");
            prop.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            Message mess = new MimeMessage(session);
            mess.setFrom(new InternetAddress(fromEmail));
            if (toEmail == null || toEmail.trim().isEmpty()) {
                throw new AddressException("Recipient email cannot be null or empty.");
            }
            mess.addRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));

            String emailSubject = "ESTÉE LAUDER - Xác nhận phản hồi của bạn!";
            try {
                mess.setSubject(MimeUtility.encodeText(emailSubject, "UTF-8", null));
            } catch (UnsupportedEncodingException ex) {
                Logger.getLogger(EmailHandler.class.getName()).log(Level.SEVERE, "Failed to encode subject", ex);
                mess.setSubject(emailSubject);
            }

            String content = "<!DOCTYPE html>"
                    + "<html>"
                    + "<head>"
                    + "    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">"
                    + "    <title>Xác nhận phản hồi</title>"
                    + "    <style>"
                    + "        .container { margin: 50px 200px; background-color: #F3F3F3; padding: 25px; }"
                    + "    </style>"
                    + "</head>"
                    + "<body style=\"padding: 30px;\">"
                    + "    <div>"
                    + "        <h2 style=\"font-size: 25px;\">Cảm ơn " + name + " đã quan tâm đến các sản phẩm của <a href=\"http://localhost:8080/Project_SWP/ProductListServlet\">Estée Lauder</a></h2>"
                    + "        <p>Chúng tôi rất trân trọng ý kiến của bạn và đã ghi nhận thông tin liên hệ thành công.</p>"
                    + "        <h1 style=\"margin-top: 50px; font-size: 28px\">Chi tiết phản hồi của bạn</h1>"
                    + "        <table style=\"width:100%;border-spacing:inherit;border:1px solid #ddd\">"
                    + "            <tr style=\"background-color:#ce0707;font-weight:bold\">"
                    + "                <td style=\"padding:10px;border-right:1px solid #ddd;color:white\">THÔNG TIN NGƯỜI GỬI</td>"
                    + "                <td style=\"padding:10px;color:white\">NỘI DUNG PHẢN HỒI</td>"
                    + "            </tr>"
                    + "            <tr style=\"color:#ce0707\">"
                    + "                <td style=\"padding:10px;border-right:1px solid #ddd\">Tên: " + name + "</td>"
                    + "                <td style=\"padding:10px\">Chủ đề: " + subject + "</td>"
                    + "            </tr>"
                    + "            <tr style=\"color:#ce0707\">"
                    + "                <td style=\"padding:10px;border-right:1px solid #ddd;\">Email: " + toEmail + "</td>"
                    + "                <td style=\"padding:10px\">Tin nhắn: " + message + "</td>"
                    + "            </tr>"
                    + "        </table>"
                    + "        <p>Đội ngũ Estée Lauder sẽ liên hệ với bạn trong thời gian sớm nhất để hỗ trợ tốt hơn. Xin cảm ơn!</p>"
                    + "        <h2>ESTÉE LAUDER</h2>"
                    + "    </div>"
                    + "</body>"
                    + "</html>";

            mess.setContent(content, "text/html;charset=UTF-8");
            Transport.send(mess);

        } catch (NamingException ex) {
            Logger.getLogger(EmailHandler.class.getName()).log(Level.SEVERE, "Failed to lookup email credentials", ex);
            throw new MessagingException("Failed to send contact confirmation email due to configuration error", ex);
        } catch (MessagingException ex) {
            Logger.getLogger(EmailHandler.class.getName()).log(Level.SEVERE, "Failed to send contact confirmation email", ex);
            throw ex;
        }
    }

    public static String generateCodeVerify() {
        Random rd = new Random();
        int codeVerify = rd.nextInt(899999) + 100000;

        return String.valueOf(codeVerify);
    }
}
