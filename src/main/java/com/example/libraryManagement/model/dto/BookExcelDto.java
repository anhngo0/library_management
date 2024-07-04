package com.example.libraryManagement.model.dto;

import com.example.libraryManagement.model.entity.BookStatus;
import lombok.Data;
import lombok.Getter;

import java.io.Serializable;
import java.time.Year;

@Data
public class BookExcelDto {
    private String titleName;
    private String alterName;
    private String author;
    private String bookPosition;
    private int quantity;
    private String language;
    private String publisher;
    private Year year_of_publication;
    private String ISBNNumber;
    private String category ;
    private String classNumber;

}
