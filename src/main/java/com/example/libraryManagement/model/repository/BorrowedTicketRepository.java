package com.example.libraryManagement.model.repository;

import com.example.libraryManagement.model.entity.BorrowTicket;
import org.springframework.stereotype.Repository;

@Repository
public interface BorrowedTicketRepository extends ParentRepository<BorrowTicket,Long> {
}
