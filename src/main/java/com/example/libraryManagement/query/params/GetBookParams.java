package com.example.libraryManagement.query.params;

import com.example.libraryManagement.model.entity.BookStatus;
import com.example.libraryManagement.model.entity.TicketStatus;
import lombok.Data;

import java.io.Serializable;
import java.math.BigInteger;
import java.time.Year;
import java.util.List;

@Data
public class GetBookParams implements Serializable {
    private String keyword;
    private Year yearOfPublicationFrom;
    private Year yearOfPublicationTo;
    private int quantityFrom;
    private int quantityTo;
    private BookStatus status;
    private boolean isBorrowed;
    private Long categoryId;
    private Long classNumberId;
    private Long liquidationTicketId;
}
