package com.example.libraryManagement.model.dto.form;

import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

@Data
public class UpsertProfileForm {
    @NotBlank
    private String name;

    @JsonFormat(pattern="yyyy-MM-dd")
    private LocalDate DoB;

    @NotBlank
    private String cccd_Id;

    private String address;
    @NotBlank
    private String phone;
    @NotBlank
    private String email;
}
