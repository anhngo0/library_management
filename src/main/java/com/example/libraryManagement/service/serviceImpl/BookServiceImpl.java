package com.example.libraryManagement.service.serviceImpl;

import com.example.libraryManagement.exeption.ResourceNotFoundException;
import com.example.libraryManagement.mapper.BookMapper;
import com.example.libraryManagement.model.dto.BookDto;
import com.example.libraryManagement.model.dto.BookExcelDto;
import com.example.libraryManagement.model.dto.form.UpsertBookForm;
import com.example.libraryManagement.model.dto.form.UpsertExcelBookForm;
import com.example.libraryManagement.model.dto.fullInfo.BookFullInfoDto;
import com.example.libraryManagement.model.entity.Book;
import com.example.libraryManagement.model.entity.BookStatus;
import com.example.libraryManagement.model.entity.FileDescription;
import com.example.libraryManagement.model.repository.BookRepository;
import com.example.libraryManagement.query.params.GetBookParams;
import com.example.libraryManagement.query.predicate.BookPredicate;
import com.example.libraryManagement.service.IBookService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.*;
import java.util.concurrent.CompletableFuture;

@Service
@RequiredArgsConstructor
public class BookServiceImpl implements IBookService {
    private final BookRepository bookRepository;
    private final BookMapper bookMapper;
    private final FileStorageService fileStorageService;

    @Override
    public Page<BookDto> getBooks(GetBookParams getBookParams, Pageable pageable){
        return bookRepository
                .findAll(BookPredicate.getBooks(getBookParams), pageable)
                .map(bookMapper::toDto)
                ;
    }

    @Override
    @Transactional
    public BookDto createBook(UpsertBookForm upsertBookForm, MultipartFile file) {
        Book newBook = bookMapper.toEntity(upsertBookForm);
        newBook.setStatus(BookStatus.IN_USE);

        newBook = bookRepository.save(newBook);
        Book finalNewBook = newBook;
        CompletableFuture.runAsync(() -> {
            if (file != null && !file.isEmpty()) {
                try {
                    finalNewBook.setData(file.getBytes());
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        });
      bookRepository.save(finalNewBook);

        return bookMapper.toDto(finalNewBook);
    }


    @Override
    public BookDto updateBook(Long bookId, UpsertBookForm upsertBookForm, MultipartFile file) throws IOException {
        Book book = bookRepository.findById(bookId).orElseThrow(() -> new ResourceNotFoundException("resource not found"));
        Book updatedbook = bookMapper.toEntity_updateBook(book, upsertBookForm);
        updatedbook = bookRepository.save(updatedbook);
        if (file != null && !file.isEmpty()) {
            updatedbook.setData(file.getBytes());
        }
        updatedbook = bookRepository.save(updatedbook);
        return bookMapper.toDto(updatedbook);
    }

    @Override
    @Transactional
    public Object deleteBook(Long bookId) {
        Book book = bookRepository.findById(bookId).orElseThrow(() -> new ResourceNotFoundException("resource not found"));
        bookRepository.delete(book);
        return null;
    }

    @Override
    public Object deleteMultipleBooks(List<Long> listBookIds) {
        if(!listBookIds.isEmpty()){
            bookRepository.deleteAllById(listBookIds);
        };
        return null;
    }

    @Override
    public BookFullInfoDto getBookFullInfoById(Long id) {
        Book book = bookRepository.findById(id).orElseThrow(()-> new ResourceNotFoundException("resource not found"));
        return bookMapper.toFullInfoDto(book);
    }


    @Override
    public void setBookState(Set<Book> books, BookStatus status){
        books.forEach(book -> book.setStatus(status));
        bookRepository.saveAll(books);
    }

    @Override
    public void setBookIsBorrowedState(Set<Book> books, boolean isBorrowed){
        books.forEach(book -> book.setBorrowed(isBorrowed));
        bookRepository.saveAll(books);
    }

    @Override
    public List<BookExcelDto> getBooksList(GetBookParams getBookParams) {
        List<BookExcelDto> bookList = new ArrayList<BookExcelDto>();
         Iterable<Book> books = bookRepository
                .findAll(BookPredicate.getBooks(getBookParams));
         books.forEach(book -> bookList.add(bookMapper.toExcelDto(book)));
         return bookList;
    }

    @Override
    public void createMultipleBooks(List<UpsertExcelBookForm> list) {
        List<Book> books = new ArrayList<Book>();
        List<Book> finalBooks = books;
        list.forEach(bookForm -> {
            Book book = bookMapper.toEntity(bookForm);
            finalBooks.add(book);
        });
        books = bookRepository.saveAll(books);
    }

    @Override
    public void removeBookFromSpecialList(List<Long> bookList) {
        List<Book> books = bookRepository.findAllById(bookList);
        books.forEach(book -> book.setStatus(BookStatus.IN_USE));
        bookRepository.saveAll(books);
    }

    @Override
    public BookDto getBookById(Long id) {
        Book book = bookRepository.findById(id).orElseThrow(()-> new ResourceNotFoundException("resource not found"));
        return bookMapper.toDto(book);
    }

    @Override
    public Page<BookDto> getBooksInUseNew(Pageable pageable) {
        return bookRepository
                .findAll(BookPredicate.getBooksInUseNew(),pageable)
                .map(bookMapper::toDto)
                ;
    }

    @Override
    public Page<BookDto> getBooksInUseNominated(Pageable pageable) {
        return bookRepository.findAllStatusNominated(pageable).map(bookMapper::toDto);
    }

    @Override
    public void changeBookStatusToNew(Long bookId) {
        Book book = bookRepository.findById(bookId).orElseThrow(() -> new ResourceNotFoundException("No book has found"));
        book.setStatus(BookStatus.IN_USE_NEW);
        book = bookRepository.save(book);
    }

    @Override
    public void changeBookStatusToNominated(Long bookId) {
        Book book = bookRepository.findById(bookId).orElseThrow(() -> new ResourceNotFoundException("No book has found"));
        book.setStatus(BookStatus.IN_USE_NOMINATED);
        book = bookRepository.save(book);
    }
}
