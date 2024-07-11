package com.example.libraryManagement.model.dto;

import com.example.libraryManagement.model.entity.TicketStatus;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
public class ImportTicketDto {
    private Long id;
    private LocalDateTime created_date;
    private Double totalPrice;
    private String supplier;
    private String creator_name;
    private String approver_name;
    private LocalDateTime approval_date;
    private TicketStatus status;
    private String import_way;
}
