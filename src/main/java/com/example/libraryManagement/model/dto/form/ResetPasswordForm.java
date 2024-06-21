package com.example.libraryManagement.model.dto.form;

import lombok.Data;

@Data
public class ResetPasswordForm {
    private String newPassword;
    private String resetKey;
}
