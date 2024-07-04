package com.example.libraryManagement.model.dto;

import lombok.Data;

import java.io.Serializable;

@Data
public class PermissionDto {
    private Long id;
    private String name;
    private String description;
}
