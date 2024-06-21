package com.example.libraryManagement.controller;

import com.example.libraryManagement.model.dto.PermissionDto;
import com.example.libraryManagement.query.params.GetPermissionParam;
import com.example.libraryManagement.service.IPermissionService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.PagedModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/permission")
@RequiredArgsConstructor
public class PermissionController {
    private final IPermissionService permissionService;
    private final PagedResourcesAssembler<PermissionDto> pagedResourcesAssembler;

    @GetMapping
    public ResponseEntity<PagedModel<EntityModel<PermissionDto>>> getPermissions(
            GetPermissionParam getPermissionParam, Pageable pageable
    ){
        PagedModel<EntityModel<PermissionDto>> page = pagedResourcesAssembler.toModel(
                permissionService.getPermissions(getPermissionParam,pageable)
        );
        return ResponseEntity.ok(page);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<PermissionDto> deletePermissionByid(@PathVariable Long id){
        return ResponseEntity.ok(permissionService.deletePermisionById(id));
    }

    @PostMapping()
    public ResponseEntity<?> createPermissions(){
        permissionService.createPermission();
        return ResponseEntity.ok("create success");
    }
}
