package com.example.libraryManagement.query.params;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

@Data
public class GetBorrowTicketParams {
    //@param listIds -> is : list of borrowedTicket's ids asocciated to a specific book
    //               -> used when: query borrowedTickets of a book
    private List<Long> listIds;
    private String keyword;
    private LocalDateTime borrowed_from;
    private LocalDateTime borrowed_to;
    private LocalDateTime returned_from;
    private LocalDateTime returned_to;
    private Long librarianId;
    private Long memberId;
}
