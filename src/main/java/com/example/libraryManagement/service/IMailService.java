package com.example.libraryManagement.service;

import org.springframework.scheduling.annotation.Async;

public interface IMailService {
    @Async
    void sendResetPasswordEmail(String toEmail, String resetKey);
}
