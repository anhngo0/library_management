package com.example.libraryManagement.service;

import com.example.libraryManagement.model.dto.BookCategoryDto;
import com.example.libraryManagement.model.dto.form.UpsertBookCategoryForm;
import com.example.libraryManagement.model.entity.BookCategory;
import com.example.libraryManagement.query.params.GetBookCategoriesQueryParams;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface IBookCategoryService {
    public Page<BookCategoryDto> getBookCategories(GetBookCategoriesQueryParams getBookCategoriesQueryParams, Pageable pageable);

    BookCategoryDto getBookCategoryById(Long id);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    BookCategoryDto createBookCategory(UpsertBookCategoryForm upsertBookCategoryForm);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    BookCategoryDto updateBookCategory(Long id,UpsertBookCategoryForm upsertBookCategoryForm);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    Object deleteBookCategory(Long id);
}
