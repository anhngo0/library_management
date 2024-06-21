package com.example.libraryManagement.mapper;

import com.example.libraryManagement.model.dto.RoleDto;
import com.example.libraryManagement.model.dto.form.UpsertRoleForm;
import com.example.libraryManagement.model.entity.Permission;
import com.example.libraryManagement.model.entity.Role;
import com.example.libraryManagement.model.repository.PermissionRepository;
import lombok.RequiredArgsConstructor;
import org.mapstruct.*;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Set;


@Mapper(componentModel = MappingConstants.ComponentModel.SPRING, uses = {PermissionMapper.class, IdToEntityMapper.class})
public abstract class RoleMapper {
    @Autowired
    private PermissionRepository permissionRepository;

    public abstract Role toEntity(RoleDto roleDto);

    @Mapping(source = "permissions", target = "permissions")
   public abstract RoleDto toDto(Role role);

    @Mapping(source = "permissions", target = "permissions", qualifiedByName = "permissionStringToPermissionEntity")
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE, unmappedTargetPolicy = ReportingPolicy.IGNORE)
    public abstract Role toEntity(UpsertRoleForm upsertRoleForm);

    @Mapping(source = "permissions", target = "permissions", qualifiedByName = "permissionStringToPermissionEntity")
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE, unmappedTargetPolicy = ReportingPolicy.IGNORE)
    public abstract Role toEntity_update(UpsertRoleForm upsertRoleForm,@MappingTarget Role role) ;

    @Named(value = "permissionStringToPermissionEntity")
    Set<Permission> permissionStringToPermissionEntity(Set<String> stringPermissions){
        if(stringPermissions == null || stringPermissions.isEmpty()){
            return null;
        }
        return permissionRepository.findByNameInIgnoreCase(stringPermissions);
    }
}
