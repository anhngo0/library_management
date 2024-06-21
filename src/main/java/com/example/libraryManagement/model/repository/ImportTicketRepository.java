package com.example.libraryManagement.model.repository;

import com.example.libraryManagement.model.entity.ImportTicket;
import org.springframework.stereotype.Repository;

@Repository
public interface ImportTicketRepository extends ParentRepository<ImportTicket,Long> {
}
