package com.example.libraryManagement.model.dto.form;

import com.example.libraryManagement.model.dto.BookDto;
import com.example.libraryManagement.model.dto.ProfileMinInfoDto;
import com.example.libraryManagement.model.entity.TicketStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CreateLiquidationTicketForm {
    private String creator_note;
    private BigDecimal export_price;
    private Integer totalQuantity;
    Set<Long> bookIds;
}
