package com.example.libraryManagement.model.dto.form;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RespondImportTicketForm {
    private String approver_note;
    @NotNull(message = "{respondTicketStatusIsRequired}")
    private Boolean isAccepted;
}
