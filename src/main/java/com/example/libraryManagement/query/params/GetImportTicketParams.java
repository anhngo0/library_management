package com.example.libraryManagement.query.params;

import com.example.libraryManagement.model.entity.Profile;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;

@Data
public class GetImportTicketParams {
    private String keyword;
    private Double totalPrice_from;
    private Double totalPrice_to;
    private LocalDateTime create_from;
    private LocalDateTime create_to;
    private Integer totalQuantity_from;
    private Integer totalQuantity_to;
    private Long librarianId;
    private Long managerId;
}
