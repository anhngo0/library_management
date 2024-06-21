package com.example.libraryManagement.mapper;

import com.example.libraryManagement.model.dto.PermissionDto;
import com.example.libraryManagement.model.entity.Permission;
import org.mapstruct.*;

@Mapper(
        componentModel = MappingConstants.ComponentModel.SPRING
)
public abstract class PermissionMapper {
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    public abstract Permission toEntity(PermissionDto permissionDto);

    public abstract PermissionDto toDto(Permission permission);

}
