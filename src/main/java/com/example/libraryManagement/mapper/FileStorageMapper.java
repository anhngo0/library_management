package com.example.libraryManagement.mapper;

import com.example.libraryManagement.model.dto.FileStorageDto;
import com.example.libraryManagement.model.entity.FileStorage;
import org.mapstruct.*;

import javax.swing.*;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING,
uses = {IdToEntityMapper.class})
public abstract class FileStorageMapper {
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE, unmappedTargetPolicy = ReportingPolicy.IGNORE)
    public abstract FileStorageDto toDto(FileStorage file);


}

