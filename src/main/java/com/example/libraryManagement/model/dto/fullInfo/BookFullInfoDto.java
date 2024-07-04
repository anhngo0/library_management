package com.example.libraryManagement.model.dto.fullInfo;

import com.example.libraryManagement.model.dto.BookCategoryDto;
import com.example.libraryManagement.model.dto.BookClassNumberDto;
import com.example.libraryManagement.model.dto.ImportTicketDto;
import com.example.libraryManagement.model.dto.LiquidationTicketDto;
import com.example.libraryManagement.model.entity.BookStatus;
import lombok.Data;

import java.io.Serializable;
import java.math.BigInteger;
import java.time.Year;

@Data
public class BookFullInfoDto {
    private Long id;
    private String titleName;
    private String alterName;
    private String author;
    private String ISBNNumber;
    private String bookPosition;
    private Double price;
    private int quantity;
    private Year year_of_publication;
    private String publisher;
    private String language;
    private String description;
    private boolean isBorrowed;
    private BookStatus status;
    private BookCategoryDto category;
    private BookClassNumberDto classNumber;

    private LiquidationTicketDto liquidationTicket;
}
