package com.example.libraryManagement.service;

import com.example.libraryManagement.model.dto.BorrowTicketDto;
import com.example.libraryManagement.model.dto.form.AcceptBorrowTicketForm;
import com.example.libraryManagement.model.dto.form.CreateBorrowTicketForm;
import com.example.libraryManagement.model.dto.fullInfo.BorrowTicketFullInfoDto;
import com.example.libraryManagement.query.params.GetBorrowTicketParams;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;

public interface IBorrowedTicketService {
    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"BORROW.READ\")")
    Page<BorrowTicketDto> getBorrowedTickets(GetBorrowTicketParams getBorrowTicketParams, Pageable pageable);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"BORROW.READ\")")
    BorrowTicketFullInfoDto getBorrowedTicketFullInfo(Long id);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"BORROW.UPDATE\")")
    BorrowTicketDto updateBorrowedTicket(Long id, CreateBorrowTicketForm createBorrowTicketForm);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"BORROW.DELETE\")")
    void deleteBorrowedTicket(Long id);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"BORROW.ACCEPT\")")
    BorrowTicketDto respondBorrowedTicket(Long id, AcceptBorrowTicketForm acceptBorrowTicketForm);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"BORROW.CREATE\")")
    BorrowTicketDto createBorrowedTicket(CreateBorrowTicketForm createBorrowTicketForm);
}
