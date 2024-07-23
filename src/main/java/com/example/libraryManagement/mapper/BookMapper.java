package com.example.libraryManagement.mapper;

import com.example.libraryManagement.model.dto.BookDto;
import com.example.libraryManagement.model.dto.BookExcelDto;
import com.example.libraryManagement.model.dto.form.UpsertBookForm;
import com.example.libraryManagement.model.dto.form.UpsertExcelBookForm;
import com.example.libraryManagement.model.dto.fullInfo.BookFullInfoDto;
import com.example.libraryManagement.model.entity.Book;
import com.example.libraryManagement.model.entity.BookCategory;
import com.example.libraryManagement.model.entity.BookStatus;
import org.mapstruct.*;

import java.util.Base64;

@Mapper(
        componentModel = MappingConstants.ComponentModel.SPRING, uses = {
                IdToEntityMapper.class,LiquidationMapper.class, NameToEntityMapper.class
}, imports = {BookStatus.class, Base64.class}
)
public abstract class BookMapper {

    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE, nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    @Mapping(target = "base64Data", source = "data", qualifiedByName = "encodePassword")
    public abstract BookDto toDto(Book book);

    @Mapping(source = "category.name", target = "category")
    @Mapping(source = "classNumber.name", target = "classNumber")
    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE)
    public abstract BookExcelDto toExcelDto(Book book);

    @Mapping(target = "status", expression = "java(BookStatus.IN_USE)")
    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE)
    public abstract Book toEntity(UpsertExcelBookForm upsertExcelBookForm);

    @BeanMapping(nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    @Mapping(target = "base64Data", source = "data", qualifiedByName = "encodePassword")
    public abstract BookFullInfoDto toFullInfoDto(Book book);

    @Mapping(source = "categoryId", target = "category")
    @Mapping(source = "classNumberId", target = "classNumber")
    @Mapping(target = "status", expression = "java(BookStatus.IN_USE)")
    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE, nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    public abstract Book toEntity(UpsertBookForm upsertBookForm);

    @Mapping(source = "categoryId", target = "category")
    @Mapping(source = "classNumberId", target = "classNumber")
    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE, nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    public abstract Book toEntity_updateBook(@MappingTarget Book book,  UpsertBookForm upsertBookForm);

    @Named("encodePassword")
    public String encodePassword(byte[] data) {
        return data == null ? null : Base64.getEncoder().encodeToString(data);
    }
}
