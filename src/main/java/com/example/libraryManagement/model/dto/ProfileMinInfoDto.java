package com.example.libraryManagement.model.dto;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.util.Date;

@Data
public class ProfileMinInfoDto {
    private Long id;
    private String name;
    private String phone;
    private String email;
}
