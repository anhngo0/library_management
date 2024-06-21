package com.example.libraryManagement.mapper;

import com.example.libraryManagement.exeption.ResourceNotFoundException;
import com.example.libraryManagement.model.entity.BookCategory;
import com.example.libraryManagement.model.entity.BookClassNumber;
import com.example.libraryManagement.model.repository.BookCategoryRepository;
import com.example.libraryManagement.model.repository.BookClassNumberRepository;
import org.apache.commons.lang3.StringUtils;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ObjectUtils;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public class NameToEntityMapper {
    @Autowired
    protected BookCategoryRepository categoryRepository;

    @Autowired
    protected BookClassNumberRepository bookClassNumberRepository;
    public BookCategory toCategory(String category){
        return !StringUtils.isEmpty(category) ?
                categoryRepository.findByName(category).orElseThrow(() -> new ResourceNotFoundException("resource not found"))
                : null;
    }

    public BookClassNumber toClassNumber(String bookClassNumber){
        return !StringUtils.isEmpty(bookClassNumber) ?
                bookClassNumberRepository.findByName(bookClassNumber).orElseThrow(() -> new ResourceNotFoundException("resource not found"))
                :null;
    }
}
