package com.example.libraryManagement.service;

import com.example.libraryManagement.model.dto.BookDto;
import com.example.libraryManagement.model.dto.BookExcelDto;
import com.example.libraryManagement.model.dto.form.UpsertBookForm;
import com.example.libraryManagement.model.dto.form.UpsertExcelBookForm;
import com.example.libraryManagement.model.dto.fullInfo.BookFullInfoDto;
import com.example.libraryManagement.model.entity.Book;
import com.example.libraryManagement.model.entity.BookStatus;
import com.example.libraryManagement.query.params.GetBookParams;
import com.example.libraryManagement.query.params.GetImportTicketParams;
import com.example.libraryManagement.query.params.GetLiquidationTicketParams;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.Arrays;
import java.util.List;
import java.util.Set;

@Service
public interface IBookService {

    Page<BookDto> getBooks(GetBookParams getBookParams, Pageable pageable);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"BOOK.CREATE\")")
    BookDto createBook(UpsertBookForm upsertBookForm, MultipartFile file);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"BOOK.UPDATE\")")
    BookDto updateBook(Long bookId, UpsertBookForm upsertBookForm, MultipartFile file);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"BOOK.DELETE\")")
    Object deleteBook(Long bookId);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"BOOK.DELETE\")")
    Object deleteMultipleBooks(List<Long> listBookIds);

    BookFullInfoDto getBookFullInfoById(Long id);


    void setBookState(Set<Book> books, BookStatus status);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN')")
    void setBookIsBorrowedState(Set<Book> books, boolean isBorrowed);

    List<BookExcelDto> getBooksList(GetBookParams getBookParams);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"BOOK.CREATE\")")
    void createMultipleBooks(List<UpsertExcelBookForm> list);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER') or hasAuthorities(\"BOOK.CHANGE_STATUS\")")
    void changeListStatus(List<Long> bookList, BookStatus status);

    BookDto getBookById(Long id);
}
