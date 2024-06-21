package com.example.libraryManagement.service;

import com.example.libraryManagement.model.dto.RoleDto;
import com.example.libraryManagement.model.dto.form.UpsertRoleForm;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.List;

public interface IRoleService {
    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    List<RoleDto> getAllRole();

    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    RoleDto getRoleById(Long id);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    RoleDto createRole(UpsertRoleForm upsertRoleForm);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    RoleDto updateRole(UpsertRoleForm upsertRoleForm, Long id);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    void deleteRoleById(Long id);
}
