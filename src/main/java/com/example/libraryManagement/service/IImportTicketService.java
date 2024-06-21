package com.example.libraryManagement.service;

import com.example.libraryManagement.model.dto.ImportTicketDto;
import com.example.libraryManagement.model.dto.form.CreateImportTicketForm;
import com.example.libraryManagement.model.dto.form.RespondImportTicketForm;
import com.example.libraryManagement.model.dto.fullInfo.ImportTicketFullInfoDto;
import com.example.libraryManagement.query.params.GetImportTicketParams;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface IImportTicketService {
    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"IMPORT.CREATE\")")
    ImportTicketDto createImportTicket(CreateImportTicketForm createImportTicketForm, MultipartFile file);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"IMPORT.READ\")")
    Page<ImportTicketDto> getImportTickets(GetImportTicketParams getImportTicketParams, Pageable pageable);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"IMPORT.READ\")")
    ImportTicketFullInfoDto getImportTicketFullInfoById(Long id);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"IMPORT.UPDATE\")")
    ImportTicketDto updateImportTicket(Long id, CreateImportTicketForm createImportTicketForm, MultipartFile file);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER') ")
    ImportTicketDto respondImportTicket(Long id, RespondImportTicketForm respondImportTicketForm);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"IMPORT.DELETE\")")
    void deleteMultiple(List<Long> list);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"IMPORT.DELETE\")")
    void deleteImporTicket(Long id);
}
