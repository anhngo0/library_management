package com.example.libraryManagement.service.serviceImpl;

import com.example.libraryManagement.service.IMailService;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;

@Service
@RequiredArgsConstructor
public class MailService implements IMailService {

    Logger logger = LoggerFactory.getLogger(MailService.class);

    private final JavaMailSender mailSender;

    @Value("${spring.mail.username}")
    private String from;

    @Value("${spring.mail.base-url}")
    private String baseUrl;

    @Async
    public void sendResetPasswordEmail(String toEmail, String resetKey){
        sendResetPasswordEmailSync(toEmail, resetKey);
    }

    public void sendResetPasswordEmailSync(String toEmail, String resetKey) {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        try {
            MimeMessageHelper message = new MimeMessageHelper(mimeMessage,false, StandardCharsets.UTF_8.name());
            message.setTo(toEmail);
            message.setFrom(from);
            message.setSubject("Làm mới mật khẩu");
            String htmlContent = "<html><body><p>click vào link sau để làm mới mật khẩu <a href='" + baseUrl + "/reset-password/confirm?uuid="
                    + resetKey + "'>Làm mới mật khẩu</a> .</p></body></html>";
            message.setText(htmlContent, true);
            mailSender.send(mimeMessage);
            logger.debug("Sent email to User '{}'", toEmail);
        } catch (MailException | MessagingException e) {
            logger.warn("Email could not be sent to user '{}'", toEmail, e);
        }
    }
}
