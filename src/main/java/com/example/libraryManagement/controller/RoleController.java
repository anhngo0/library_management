package com.example.libraryManagement.controller;

import com.example.libraryManagement.model.dto.RoleDto;
import com.example.libraryManagement.model.dto.form.UpsertRoleForm;
import com.example.libraryManagement.service.IRoleService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/role")
@RequiredArgsConstructor
public class RoleController {
    private final IRoleService roleService;
    @GetMapping
    public ResponseEntity<List<RoleDto>> getAllRoles(){
        return ResponseEntity.ok(roleService.getAllRole());
    }
    @GetMapping("/{id}")
    public ResponseEntity<RoleDto> getRoleById(@PathVariable("id") Long id){
        return ResponseEntity.ok(roleService.getRoleById(id));
    }

    @PostMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<RoleDto> createRole(@RequestBody @Valid UpsertRoleForm upsertRoleForm){
        return ResponseEntity.ok(roleService.createRole(upsertRoleForm));
    }

    @PutMapping("/{id}")
    public ResponseEntity<RoleDto> updateRole(@RequestBody UpsertRoleForm upsertRoleForm, @PathVariable("id") Long id){
        return ResponseEntity.ok(roleService.updateRole(upsertRoleForm,id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteRoleById(@PathVariable("id") Long id){
        roleService.deleteRoleById(id);
        return ResponseEntity.ok("delete success");
    }
}
