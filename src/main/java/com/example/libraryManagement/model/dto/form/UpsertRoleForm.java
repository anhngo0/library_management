package com.example.libraryManagement.model.dto.form;

import com.example.libraryManagement.model.dto.PermissionDto;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.Value;

import java.util.Set;

@Data
public class UpsertRoleForm {
    @NotBlank
    private String name;

    private String description;

    private Set<String> permissions;
}
