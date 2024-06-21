package com.example.libraryManagement.service.serviceImpl;

import com.example.libraryManagement.exeption.ResourceNotFoundException;
import com.example.libraryManagement.mapper.RoleMapper;
import com.example.libraryManagement.model.dto.RoleDto;
import com.example.libraryManagement.model.dto.form.UpsertRoleForm;
import com.example.libraryManagement.model.entity.Role;
import com.example.libraryManagement.model.repository.RoleRepository;
import com.example.libraryManagement.service.IRoleService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class RoleServiceImpl implements IRoleService {
    private final RoleRepository roleRepository;
    private final RoleMapper roleMapper;
    @Override
    public List<RoleDto> getAllRole() {
        List<Role> roles = roleRepository.findAll();
        List<RoleDto> roleDtos = new ArrayList<>();
                roles.forEach(role -> roleDtos.add(roleMapper.toDto(role)));
        return roleDtos;
    }

    @Override
    public RoleDto getRoleById(Long id) {
        Role role = roleRepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("resource not found"));
        return roleMapper.toDto(role);
    }

    @Override
    public RoleDto createRole(UpsertRoleForm upsertRoleForm) {
        Role role = roleMapper.toEntity(upsertRoleForm);
        role = roleRepository.save(role);
        return roleMapper.toDto(role);
    }

    @Override
    public RoleDto updateRole(UpsertRoleForm upsertRoleForm, Long id) {
        Role role = roleRepository.findById(id).orElseThrow(()-> new ResourceNotFoundException("resource not found"));
        Role updateRole = roleMapper.toEntity_update(upsertRoleForm,role);
        updateRole = roleRepository.save(updateRole);
        return roleMapper.toDto(updateRole);
    }

    @Override
    public void deleteRoleById(Long id) {
        Role role = roleRepository.findById(id).orElseThrow(()-> new ResourceNotFoundException("resource not found"));
        roleRepository.delete(role);
    }
}
