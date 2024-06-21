package com.example.libraryManagement.model.dto.fullInfo;

import com.example.libraryManagement.model.dto.BookDto;
import com.example.libraryManagement.model.dto.ProfileMinInfoDto;
import com.example.libraryManagement.model.entity.TicketStatus;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;
import java.util.Set;

@Data
public class BorrowTicketFullInfoDto  implements Serializable {
    private Long id;
    private LocalDateTime borrowed_date;
    private LocalDateTime returned_date;
    private ProfileMinInfoDto member;
    private ProfileMinInfoDto librarian;
    private String note;
    private TicketStatus status;
    private Set<BookDto> books;
}
