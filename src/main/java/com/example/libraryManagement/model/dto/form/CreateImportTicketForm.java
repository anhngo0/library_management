package com.example.libraryManagement.model.dto.form;

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
public class CreateImportTicketForm {
    private String creator_note;
    private Double totalPrice;
    private String import_way;
    private String supplier;
    private int totalQuantity;
}
