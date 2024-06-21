package com.example.libraryManagement.mapper;

import com.example.libraryManagement.model.dto.BookCategoryDto;
import com.example.libraryManagement.model.dto.form.UpsertBookCategoryForm;
import com.example.libraryManagement.model.entity.BookCategory;
import org.mapstruct.*;

import java.awt.*;

@Mapper(
        componentModel = MappingConstants.ComponentModel.SPRING, unmappedSourcePolicy = ReportingPolicy.IGNORE
)
public abstract class  BookCategoryMapper {
    public abstract BookCategoryDto toDto(BookCategory bookCategory);
    public abstract BookCategory toEntity(BookCategoryDto bookCategoryDto);
    @Mapping(target = "id", ignore = true)
    public abstract BookCategory toEntity(UpsertBookCategoryForm upsertBookCategoryForm);

    @Mapping(target = "id", ignore = true)
    public abstract BookCategory toEntityUpdate(UpsertBookCategoryForm upsertBookCategoryForm, @MappingTarget BookCategory bookCategory);

}
