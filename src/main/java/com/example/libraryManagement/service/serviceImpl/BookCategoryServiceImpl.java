package com.example.libraryManagement.service.serviceImpl;

import com.example.libraryManagement.exeption.ResourceNotFoundException;
import com.example.libraryManagement.mapper.BookCategoryMapper;
import com.example.libraryManagement.model.dto.BookCategoryDto;
import com.example.libraryManagement.model.dto.form.UpsertBookCategoryForm;
import com.example.libraryManagement.model.entity.BookCategory;
import com.example.libraryManagement.model.repository.BookCategoryRepository;
import com.example.libraryManagement.query.params.GetBookCategoriesQueryParams;
import com.example.libraryManagement.query.predicate.BookCategoryPredicate;
import com.example.libraryManagement.service.IBookCategoryService;
import com.querydsl.core.types.Predicate;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BookCategoryServiceImpl implements IBookCategoryService {
    private final BookCategoryRepository bookCategoryRepository;
    private final BookCategoryMapper bookCategoryMapper;
    public Page<BookCategoryDto> getBookCategories(
            GetBookCategoriesQueryParams getBookCategoriesQueryParams, Pageable pageable
    ){
        Predicate bookCategoryPredicate = BookCategoryPredicate.getBookCategoryPredicate(getBookCategoriesQueryParams);

        return bookCategoryRepository.findAll(
                bookCategoryPredicate,
                pageable
        ).map(bookCategoryMapper::toDto);
    }

    @Override
    public BookCategoryDto getBookCategoryById(Long id) {
        BookCategory bookCategory = bookCategoryRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Can not found book category which id is "+ id));
        return bookCategoryMapper.toDto(bookCategory);
    }

    @Override
    public BookCategoryDto createBookCategory(UpsertBookCategoryForm upsertBookCategoryForm) {
        BookCategory bookCategory = bookCategoryMapper.toEntity(upsertBookCategoryForm);
        bookCategory = bookCategoryRepository.save(bookCategory);
        return bookCategoryMapper.toDto(bookCategory);
    }

    @Override
    public BookCategoryDto updateBookCategory(Long id,UpsertBookCategoryForm upsertBookCategoryForm) {
        BookCategory bookCategory = bookCategoryRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Can not found book category which id is "+ id));
        BookCategory updatedCategory = bookCategoryMapper.toEntityUpdate(upsertBookCategoryForm,bookCategory);
        updatedCategory = bookCategoryRepository.save(updatedCategory);
        return bookCategoryMapper.toDto(updatedCategory);
    }

    @Override
    public Object deleteBookCategory(Long id) {
        BookCategory bookCategory = bookCategoryRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Can not found book category which id is "+ id));
        bookCategoryRepository.delete(bookCategory);
        return "delete successful";
    }
}
