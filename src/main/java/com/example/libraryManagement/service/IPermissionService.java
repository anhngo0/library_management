package com.example.libraryManagement.service;

import com.example.libraryManagement.model.dto.PermissionDto;
import com.example.libraryManagement.query.params.GetPermissionParam;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface IPermissionService {
    void createPermission();

    Page<PermissionDto> getPermissions(GetPermissionParam getPermissionParam, Pageable pageable);

    PermissionDto deletePermisionById(Long id);
}
