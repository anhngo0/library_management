package com.example.libraryManagement.model.dto.form;

import com.example.libraryManagement.model.dto.ProfileMinInfoDto;
import com.example.libraryManagement.model.entity.TicketStatus;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;
@Data
public class RespondLiquidationTicketForm {
    private Boolean isAccepted;
    private String approver_note;

}
