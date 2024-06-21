package com.example.libraryManagement.service;

import com.example.libraryManagement.model.dto.LiquidationTicketDto;
import com.example.libraryManagement.model.dto.form.CreateLiquidationTicketForm;
import com.example.libraryManagement.model.dto.form.RespondLiquidationTicketForm;
import com.example.libraryManagement.model.dto.fullInfo.LiquidationTicketFullInfoDto;
import com.example.libraryManagement.query.params.GetLiquidationTicketParams;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface ILiquidationService {
    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"LIQUID.CREATE\")")
    LiquidationTicketDto createLiquidationTicket(CreateLiquidationTicketForm createLiquidationTicketForm, MultipartFile attachments);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"LIQUID.READ\")")
    Page<LiquidationTicketDto> getLiquidationTickets(GetLiquidationTicketParams getLiquidationTicketParams, Pageable pageable);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"LIQUID.READ\")")
    LiquidationTicketFullInfoDto getFullInfoById(Long id);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"LIQUID.UPDATE\")")
    LiquidationTicketDto updateLiquidationTicket(Long id, CreateLiquidationTicketForm createLiquidationTicketForm, MultipartFile attachments);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"LIQUID.DELETE\")")
    void deleteLiquidationTicket(Long id);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER') or hasAuthorities(\"LIQUID.ACCEPT\")")
    void respondLiquidationTicketForm(Long id,RespondLiquidationTicketForm respondLiquidationTicketForm);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"LIQUID.DELETE\")")
    void deleteMultiple(List<Long> ids);
}
