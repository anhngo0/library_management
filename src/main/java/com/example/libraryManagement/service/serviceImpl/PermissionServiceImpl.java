package com.example.libraryManagement.service.serviceImpl;

import com.example.libraryManagement.exeption.ResourceNotFoundException;
import com.example.libraryManagement.mapper.PermissionMapper;
import com.example.libraryManagement.model.dto.PermissionDto;
import com.example.libraryManagement.model.entity.Permission;
import com.example.libraryManagement.model.repository.PermissionRepository;
import com.example.libraryManagement.query.params.GetPermissionParam;
import com.example.libraryManagement.query.predicate.PermissionPredicate;
import com.example.libraryManagement.service.IPermissionService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Set;

@RequiredArgsConstructor
@Service
public class PermissionServiceImpl implements IPermissionService {
    private final PermissionMapper permissionMapper;
    private final PermissionRepository permissionRepository;

    @Override
    public void createPermission() {
        Set<String> permissionNames = Set.of(
                "BOOK.READ",
                "BOOK.CREATE",
                "BOOK.UPDATE",
                "BOOK.DELETE",
                "BOOK.CHANGE_STATUS",
                "BORROW.READ",
                "BORROW.UPDATE",
                "BORROW.CREATE",
                "BORROW.ACCEPT",
                "BORROW.DELETE",
                "IMPORT.READ",
                "IMPORT.UPDATE",
                "IMPORT.CREATE",
                "IMPORT.ACCEPT",
                "IMPORT.DELETE",
                "LIQUID.READ",
                "LIQUID.UPDATE",
                "LIQUID.CREATE",
                "LIQUID.ACCEPT",
                "LIQUID.DELETE",
                "PROFILE.READ",
                "PROFILE.CREATE",
                "PROFILE.UPDATE",
                "PROFILE.DELETE",
                "ACCOUNT.READ",
                "ACCOUNT.UPDATE",
                "ACCOUNT.CREATE",
                "ACCOUNT.DELETE",
                "ROLE.READ",
                "ROLE.CREATE",
                "ROLE.UPDATE",
                "ROLE.DELETE"
        );
        for (String permissionName : permissionNames) {
            Permission permission = new Permission();
            permission.setName(permissionName);
            try {
                permissionRepository.save(permission);
            } catch (Exception e) {
                System.out.println("Permission " + permissionName + " already exists");
            }
        }
    }

    @Override
    public Page<PermissionDto> getPermissions(GetPermissionParam getPermissionParam, Pageable pageable) {
        Page<PermissionDto> page = permissionRepository.findAll(
                PermissionPredicate.getPermissions(getPermissionParam), pageable
        ).map(permissionMapper::toDto);
        return page;
    }

    @Override
    public PermissionDto deletePermisionById(Long id) {
        Permission permission = permissionRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("resource not found"));
        permissionRepository.delete(permission);
        return permissionMapper.toDto(permission);
    }
}
