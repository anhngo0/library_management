package com.example.libraryManagement.model.dto;

import com.example.libraryManagement.model.entity.TicketStatus;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

@Data
public class BorrowTicketDto  {
    private Long id;
    private LocalDateTime borrowed_date;
    private LocalDateTime returned_date;
    private String member;
    private String librarian;
    private TicketStatus status;
}
