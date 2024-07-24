<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Session, javax.mail.Message, javax.mail.Transport, javax.mail.internet.InternetAddress, javax.mail.internet.MimeMessage, java.util.Properties, javax.mail.PasswordAuthentication" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registration Confirmation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        .button {
            padding: 10px 20px;
            font-size: 18px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 20px;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Customer Registered Successfully</h1>
        <p>Account Number: <strong><%= request.getAttribute("accountNo") %></strong></p>
        <p>Temporary Password: <strong><%= request.getAttribute("tempPassword") %></strong></p>
        <form method="post">
            <button type="submit" class="button">Send Email</button>
        </form>
        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String accountNo = (String) request.getAttribute("accountNo");
                String tempPassword = (String) request.getAttribute("tempPassword");
                String emailId = (String) request.getAttribute("emailId");

                String host = "smtp.example.com"; // Replace with your SMTP server
                final String username = "your_email@example.com"; // Replace with your email
                final String emailPassword = "your_email_password"; // Replace with your email password

                Properties props = new Properties();
                props.put("mail.smtp.auth", "true");
                props.put("mail.smtp.starttls.enable", "true");
                props.put("mail.smtp.host", host);
                props.put("mail.smtp.port", "587");

                Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, emailPassword);
                    }
                });

                try {
                    Message message = new MimeMessage(mailSession);
                    message.setFrom(new InternetAddress(username)); // Use your email as sender
                    message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(emailId));
                    message.setSubject("Your Account Details");
                    message.setText("Dear Customer,\n\nYour account has been successfully created.\n\nAccount Number: " + accountNo + "\nTemporary Password: " + tempPassword + "\n\nThank you.");

                    Transport.send(message);
                    out.println("<p>Email sent successfully.</p>");
                } catch (MessagingException e) {
                    out.println("<p>Error sending email: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>