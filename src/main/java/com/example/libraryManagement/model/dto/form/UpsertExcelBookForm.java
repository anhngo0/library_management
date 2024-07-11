package com.example.libraryManagement.model.dto.form;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.Year;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UpsertExcelBookForm  {
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
    private String category;
    private String classNumber;
}
