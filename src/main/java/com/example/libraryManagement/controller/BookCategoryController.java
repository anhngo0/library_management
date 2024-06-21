package com.example.libraryManagement.controller;

import com.example.libraryManagement.mapper.BookCategoryMapper;
import com.example.libraryManagement.model.dto.BookCategoryDto;
import com.example.libraryManagement.model.dto.form.UpsertBookCategoryForm;
import com.example.libraryManagement.query.params.GetBookCategoriesQueryParams;
import com.example.libraryManagement.service.IBookCategoryService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.PagedModel;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/book-category")
@RequiredArgsConstructor
public class BookCategoryController {
    private final IBookCategoryService bookCategoryService;
    private final PagedResourcesAssembler<BookCategoryDto> pagedResourcesAssembler;
    @GetMapping
    public ResponseEntity<PagedModel<EntityModel<BookCategoryDto>>> getBookCategories(
            GetBookCategoriesQueryParams getBookCategoriesQueryParams, Pageable pageable
    ){
        PagedModel<EntityModel<BookCategoryDto>> entityModels = pagedResourcesAssembler.toModel(
                bookCategoryService.getBookCategories(getBookCategoriesQueryParams,pageable)
        );
        return ResponseEntity.ok(entityModels);
    }
    @GetMapping("/{id}")
    public ResponseEntity<BookCategoryDto> getBookCategoryById(@PathVariable Long id){
        return ResponseEntity.ok(bookCategoryService.getBookCategoryById(id));
    }

    @PostMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<BookCategoryDto> createBookCategory(
            @RequestBody @Valid UpsertBookCategoryForm upsertBookCategoryForm
    ){
        return ResponseEntity.ok(bookCategoryService.createBookCategory(upsertBookCategoryForm));
    }

    @PutMapping(path = "/{id}",consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<BookCategoryDto> updateBookCategory(
            @PathVariable Long id,
            @RequestBody @Valid UpsertBookCategoryForm upsertBookCategoryForm
    ){
        return ResponseEntity.ok(bookCategoryService.updateBookCategory(id,upsertBookCategoryForm));
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<Object> deleteBookCategory(@PathVariable Long id){
        return ResponseEntity.ok(bookCategoryService.deleteBookCategory(id));
    }
}
