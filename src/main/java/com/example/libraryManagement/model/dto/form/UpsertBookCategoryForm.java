package com.example.libraryManagement.model.dto.form;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

import java.io.Serializable;

@Data
public class UpsertBookCategoryForm {
    @NotBlank(message = "{bookCategoryNameMustNotBeBlank}")
    private String name;
    private String note;
}
