package com.example.libraryManagement.model.dto;
import com.example.libraryManagement.model.entity.TicketStatus;
import lombok.Data;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;

@Data
public class LiquidationTicketDto  {
    private Long id;
    private LocalDateTime created_date;
    private Double export_price;
    private Integer totalQuantity;
    private String creator_name;
    private String approver_name;
    private TicketStatus status;
}
