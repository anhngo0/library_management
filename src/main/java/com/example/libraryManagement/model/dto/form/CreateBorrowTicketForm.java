package com.example.libraryManagement.model.dto.form;

import com.example.libraryManagement.model.dto.BookDto;
import com.example.libraryManagement.model.dto.ProfileMinInfoDto;
import com.example.libraryManagement.model.entity.TicketStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.Set;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CreateBorrowTicketForm {
    private Long memberId;
    private String note;
    private Set<Long> bookIds;
}
