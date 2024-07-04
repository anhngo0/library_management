package com.example.libraryManagement.model.dto;

import lombok.Data;

import java.io.Serializable;
import java.util.Set;

@Data
public class RoleDto {
    private Long id;
    private String name;
    private String description;
    private Set<PermissionDto> permissions;
}
