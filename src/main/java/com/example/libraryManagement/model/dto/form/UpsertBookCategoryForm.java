package com.example.libraryManagement.model.dto.form;

import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UpsertBookCategoryForm {
    @NotBlank(message = "{bookCategoryNameMustNotBeBlank}")
    private String name;
    private String note;
}
