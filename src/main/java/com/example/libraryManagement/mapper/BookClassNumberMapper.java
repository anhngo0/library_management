package com.example.libraryManagement.mapper;

import com.example.libraryManagement.model.dto.BookClassNumberDto;
import com.example.libraryManagement.model.dto.form.UpsertBookClassNumberForm;
import com.example.libraryManagement.model.entity.BookClassNumber;
import com.example.libraryManagement.model.entity.BookClassNumber;
import org.mapstruct.*;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public abstract class BookClassNumberMapper {
    public abstract BookClassNumberDto toDto(BookClassNumber bookClassNumber);
    public abstract BookClassNumber toEntity(BookClassNumberDto bookClassNumberDto);
    @Mapping(target = "id", ignore = true)
    public abstract BookClassNumber toEntity(UpsertBookClassNumberForm upsertBookClassNumberForm);

    @Mapping(target = "id", ignore = true)
    public abstract BookClassNumber toEntityUpdate(UpsertBookClassNumberForm upsertBookClassNumberForm, @MappingTarget BookClassNumber bookClassNumber);
}
