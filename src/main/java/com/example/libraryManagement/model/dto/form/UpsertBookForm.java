package com.example.libraryManagement.model.dto.form;

import com.example.libraryManagement.model.entity.BookStatus;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.math.BigInteger;
import java.time.Year;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UpsertBookForm {
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
    private Long categoryId;
    private Long classNumberId;
}
