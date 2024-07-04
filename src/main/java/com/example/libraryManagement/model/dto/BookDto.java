package com.example.libraryManagement.model.dto;

import com.example.libraryManagement.model.entity.BookClassNumber;
import com.example.libraryManagement.model.entity.BookStatus;
import jdk.jfr.Category;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.Year;
import java.util.Date;
import java.util.List;

@Data
@NoArgsConstructor
public class BookDto {
    private Long id;
    private String titleName;
    private String alterName;
    private String author;
    private String ISBNNumber;
    private boolean isBorrowed;
    private Year year_of_publication;
    private String publisher;
    private String bookPosition;
    private String description;
    private Double price;
    private int quantity;
    private BookCategoryDto category ;
    private BookClassNumberDto classNumber;

}
