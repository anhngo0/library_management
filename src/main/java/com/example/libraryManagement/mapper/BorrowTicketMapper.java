package com.example.libraryManagement.mapper;

import com.example.libraryManagement.model.dto.BorrowTicketDto;
import com.example.libraryManagement.model.dto.form.AcceptBorrowTicketForm;
import com.example.libraryManagement.model.dto.form.CreateBorrowTicketForm;
import com.example.libraryManagement.model.dto.fullInfo.BorrowTicketFullInfoDto;
import com.example.libraryManagement.model.entity.BorrowTicket;
import com.example.libraryManagement.model.entity.TicketStatus;
import org.mapstruct.*;

import java.time.LocalDateTime;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING,
        uses = {IdToEntityMapper.class}, imports = {LocalDateTime.class,TicketStatus.class})
public abstract class BorrowTicketMapper {
    @Mapping(source = "member.name", target = "member")
    @Mapping(source = "librarian.name", target = "librarian")
    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE)
    public abstract BorrowTicketDto toDto(BorrowTicket borrowTicket);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    public abstract BorrowTicketFullInfoDto toFullInfoDto(BorrowTicket borrowTicket);

    @Mapping(target = "borrowed_date", expression = "java(LocalDateTime.now())")
    @Mapping(source = "memberId", target = "member")
    @Mapping(source = "bookIds", target = "books")
    @Mapping(target = "status", expression = "java(TicketStatus.PENDING)")
    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE)
    public abstract BorrowTicket toEntity_create(CreateBorrowTicketForm createBorrowTicketForm);

    @Mapping(target = "returned_date", expression = "java(LocalDateTime.now())")
    @Mapping(target = "status", expression = "java(TicketStatus.ACCEPT)")
    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE)
    public abstract BorrowTicket toEntity_accept(AcceptBorrowTicketForm acceptBorrowTicketForm, @MappingTarget BorrowTicket borrowTicket);

    @Mapping(source = "memberId", target = "member")
    @Mapping(source = "bookIds", target = "books")
    public abstract BorrowTicket toEntity_update(CreateBorrowTicketForm createBorrowTicketForm, @MappingTarget BorrowTicket borrowTicket);
}
