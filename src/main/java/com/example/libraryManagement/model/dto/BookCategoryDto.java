package com.example.libraryManagement.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class BookCategoryDto {
    private Long id;
    private String name;
    private String note;
}
