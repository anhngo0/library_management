package com.example.libraryManagement.model.dto.form;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
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
