package com.example.libraryManagement.model.dto.form;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class UpsertAccountForm {
    @NotBlank
    private String username;
    @NotBlank
    private String password;
    @NotBlank
    private Long profileId;
    @NotBlank
    private Long roleId;
}
