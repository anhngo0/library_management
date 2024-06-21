package com.example.libraryManagement.model.dto.form;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Set;

@Data
public class CreateImportTicketForm {
    private String creator_note;
    private Double totalPrice;
    private String import_way;
    private String supplier;
    private int totalQuantity;
}
