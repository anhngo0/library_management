package com.example.libraryManagement.mapper;

import com.example.libraryManagement.model.dto.ImportTicketDto;
import com.example.libraryManagement.model.dto.form.CreateImportTicketForm;
import com.example.libraryManagement.model.dto.form.RespondImportTicketForm;
import com.example.libraryManagement.model.dto.fullInfo.ImportTicketFullInfoDto;
import com.example.libraryManagement.model.entity.FileDescription;
import com.example.libraryManagement.model.entity.ImportTicket;
import com.example.libraryManagement.model.entity.Ticket;
import com.example.libraryManagement.model.entity.TicketStatus;
import com.example.libraryManagement.service.serviceImpl.FileStorageService;
import org.apache.commons.lang3.ObjectUtils;
import org.mapstruct.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDateTime;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING, uses = {IdToEntityMapper.class},
        imports = {FileDescription.class, TicketStatus.class, LocalDateTime.class})
public abstract class ImportTicketMapper {
    @Autowired
    protected FileStorageService fileStorageService;

    @Mapping(source = "approver.name", target = "approver_name")
    @Mapping(source = "creator.name", target = "creator_name")
    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE)
    public abstract ImportTicketDto toDto(ImportTicket importTicket);

    @Mapping(target = "attachments", expression = "java(fileStorageService.getAllFilesOfAnEntityWithoutData(importTicket.getClass().getSimpleName(), importTicket.getId(), FileDescription.DOCUMENT))")
    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    public abstract ImportTicketFullInfoDto toFullInfoDto(ImportTicket importTicket);

    @Mapping(target = "created_date", expression = "java(LocalDateTime.now())")
    @Mapping(target = "status", expression = "java(TicketStatus.PENDING)")
    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE)
    public abstract ImportTicket toEntity_create(CreateImportTicketForm createImportTicketForm);

    @Mapping(target = "approval_date", expression = "java(LocalDateTime.now())")
    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE)
    public abstract ImportTicket toEntity_response(RespondImportTicketForm respondImportTicketForm, @MappingTarget ImportTicket importTicket);

    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE)
    public abstract ImportTicket toEntity_update(CreateImportTicketForm createImportTicketForm, @MappingTarget ImportTicket importTicket);

}
