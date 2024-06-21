package com.example.libraryManagement.controller;

import com.example.libraryManagement.model.dto.BookCategoryDto;
import com.example.libraryManagement.model.dto.BookClassNumberDto;
import com.example.libraryManagement.model.dto.form.UpsertBookCategoryForm;
import com.example.libraryManagement.model.dto.form.UpsertBookClassNumberForm;
import com.example.libraryManagement.model.dto.form.UpsertBookForm;
import com.example.libraryManagement.model.entity.BookClassNumber;
import com.example.libraryManagement.query.params.GetBookClassNumberQueryParams;
import com.example.libraryManagement.service.IBookCategoryService;
import com.example.libraryManagement.service.IBookClassNumberService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.PagedModel;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/class-number")
@RequiredArgsConstructor
public class BookClassNumberController {
    @Autowired
    private final IBookClassNumberService bookClassNumberService;
    private final PagedResourcesAssembler<BookClassNumberDto> pagedResourcesAssembler ;
    @GetMapping
    public ResponseEntity<PagedModel<EntityModel<BookClassNumberDto>>> getBookClassNumbers(
            GetBookClassNumberQueryParams getBookClassNumberQueryParams, Pageable pageable
    ){
        PagedModel<EntityModel<BookClassNumberDto>> pagedModel = pagedResourcesAssembler.toModel(
                bookClassNumberService.getBookClassNumbers(getBookClassNumberQueryParams, pageable)
        );
        return ResponseEntity.ok(pagedModel);
    }
    @GetMapping("/{id}")
    public ResponseEntity<BookClassNumberDto> getBookClassNumberById(@PathVariable Long id){
        return ResponseEntity.ok(bookClassNumberService.getBookClassNumberById(id));
    }
    @PostMapping("/many")
    public ResponseEntity<List<BookClassNumberDto>> createManyBookClassNumbers(
            @RequestBody List<UpsertBookClassNumberForm> upsertBookClassNumberFormList
    ){
        return ResponseEntity.ok(bookClassNumberService.createManyBookClassNumbers(upsertBookClassNumberFormList));
    }
    @PostMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<BookClassNumberDto> createBookClassNumber(
            @RequestBody @Valid UpsertBookClassNumberForm upsertBookClassNumberForm
    ){
        return ResponseEntity.ok(bookClassNumberService.createBookClassNumber(upsertBookClassNumberForm));
    }
    @PutMapping(path = "/{id}",consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<BookClassNumberDto> updateBookCategory(
            @PathVariable Long id,
            @RequestBody @Valid UpsertBookClassNumberForm upsertBookCategoryForm
    ){
        return ResponseEntity.ok(bookClassNumberService.updateBookClassNumber(id,upsertBookCategoryForm));
    }
    @DeleteMapping("/{id}")
    public ResponseEntity<Object> deleteBookCategory(@PathVariable Long id){
        return ResponseEntity.ok(bookClassNumberService.deleteBookClassNumberById(id));
    }
}
