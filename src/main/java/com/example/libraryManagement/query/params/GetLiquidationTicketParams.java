package com.example.libraryManagement.query.params;

import com.example.libraryManagement.model.entity.TicketStatus;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Data
public class GetLiquidationTicketParams {
    private Long creatorId;
    private Long approverId;
    private String keyword;
    private Double exportPrice_from;
    private Double exportPrice_to;
    private LocalDateTime create_from;
    private LocalDateTime create_to;
    private Integer totalQuantity_from;
    private Integer totalQuantity_to;
}
