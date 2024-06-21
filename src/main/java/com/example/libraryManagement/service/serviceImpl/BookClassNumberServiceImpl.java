package com.example.libraryManagement.service.serviceImpl;

import com.example.libraryManagement.exeption.ResourceHasExistedExeption;
import com.example.libraryManagement.exeption.ResourceNotFoundException;
import com.example.libraryManagement.mapper.BookClassNumberMapper;
import com.example.libraryManagement.model.dto.BookClassNumberDto;
import com.example.libraryManagement.model.dto.form.UpsertBookClassNumberForm;
import com.example.libraryManagement.model.dto.form.UpsertBookForm;
import com.example.libraryManagement.model.entity.BookClassNumber;
import com.example.libraryManagement.model.repository.BookClassNumberRepository;
import com.example.libraryManagement.query.params.GetBookClassNumberQueryParams;
import com.example.libraryManagement.query.predicate.BookClassNumberPredicate;
import com.example.libraryManagement.service.IBookClassNumberService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class BookClassNumberServiceImpl implements IBookClassNumberService {
    private final BookClassNumberRepository bookClassNumberRepository;
    private final BookClassNumberMapper bookClassNumberMapper;
    @Override
    public Page<BookClassNumberDto> getBookClassNumbers(
            GetBookClassNumberQueryParams getBookClassNumberQueryParams, Pageable pageable
    ) {
        Page<BookClassNumberDto> pagedBookClassNumberDto = bookClassNumberRepository
                .findAll(
                BookClassNumberPredicate.getBookClassNumberPredicate(getBookClassNumberQueryParams),
                pageable
        )
                .map((bookClassNumberMapper::toDto));
        return pagedBookClassNumberDto;
    }

    @Override
    public BookClassNumberDto getBookClassNumberById(Long id) {
        BookClassNumber bookClassNumber = bookClassNumberRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Can not found book class number which id is "+ id));
        return bookClassNumberMapper.toDto(bookClassNumber);
    }

    @Override
    public BookClassNumberDto createBookClassNumber(UpsertBookClassNumberForm upsertBookClassNumberForm) {
        BookClassNumber bookClassNumber = bookClassNumberMapper.toEntity(upsertBookClassNumberForm);
        bookClassNumber = bookClassNumberRepository.save(bookClassNumber);
        return bookClassNumberMapper.toDto(bookClassNumber);
    }

    @Override
    public BookClassNumberDto updateBookClassNumber(Long id, UpsertBookClassNumberForm upsertBookClassNumberForm) {
        BookClassNumber bookClassNumber = bookClassNumberRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Can not found book class number which id is "+ id));
        BookClassNumber updatedClassNumber = bookClassNumberMapper.toEntityUpdate(upsertBookClassNumberForm,bookClassNumber);
        updatedClassNumber = bookClassNumberRepository.save(updatedClassNumber);
        return bookClassNumberMapper.toDto(updatedClassNumber);
    }

    @Override
    public Object deleteBookClassNumberById(Long id) {
        BookClassNumber bookClassNumber = bookClassNumberRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Can not found book class number which id is "+ id));
        bookClassNumberRepository.delete(bookClassNumber);
        return "delete successful";
    }

    @Override
    public List<BookClassNumberDto> createManyBookClassNumbers(List<UpsertBookClassNumberForm> upsertBookClassNumberFormList) {
        List<BookClassNumberDto> bookClassNumberDtos = new ArrayList<>();
        for (UpsertBookClassNumberForm form: upsertBookClassNumberFormList) {
            BookClassNumber bookClassNumber = bookClassNumberMapper.toEntity(form);
            //validated existed classNumber
            if(bookClassNumberRepository.findById(bookClassNumber.getId()).isPresent()){
                throw new ResourceHasExistedExeption("Class number " + bookClassNumber.getName() + " has existed");
            }
            bookClassNumber = bookClassNumberRepository.save(bookClassNumber);
            bookClassNumberDtos.add(bookClassNumberMapper.toDto(bookClassNumber));
        }
        return bookClassNumberDtos;
    }
}
