package com.example.libraryManagement.controller;

import com.example.libraryManagement.model.dto.BookDto;
import com.example.libraryManagement.model.dto.BookExcelDto;
import com.example.libraryManagement.model.dto.form.UpsertBookForm;
import com.example.libraryManagement.model.dto.form.UpsertExcelBookForm;
import com.example.libraryManagement.model.dto.fullInfo.BookFullInfoDto;
import com.example.libraryManagement.model.entity.BookStatus;
import com.example.libraryManagement.query.params.GetBookParams;
import com.example.libraryManagement.query.params.GetImportTicketParams;
import com.example.libraryManagement.query.params.GetLiquidationTicketParams;
import com.example.libraryManagement.service.IBookService;
import com.example.libraryManagement.service.IFileStorageService;
import com.example.libraryManagement.service.IReadExcelService;
import com.example.libraryManagement.service.IWriteEcxelService;
import com.example.libraryManagement.service.serviceImpl.FileStorageService;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.PagedModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.time.LocalDateTime;
import java.util.Base64;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/v1/book")
@RequiredArgsConstructor
public class BookController {
    private final IBookService bookService;
    private final IWriteEcxelService<BookExcelDto> writeExcelService;
    private final IReadExcelService<UpsertExcelBookForm> readExcelService;
    private final IFileStorageService fileStorageService;
    private final PagedResourcesAssembler<BookDto> bookDtoPagedResourcesAssembler;
    private final Logger logger = LoggerFactory.getLogger(BookController.class);

/*  get and/or filter books
*    @param getBookParams includes of liquidationTicketId */
    @GetMapping("/read")
    ResponseEntity<PagedModel<EntityModel<BookDto>>> getBooks(GetBookParams getBookParams, Pageable pageable){
        PagedModel<EntityModel<BookDto>> pagedModel = bookDtoPagedResourcesAssembler.toModel(
                bookService.getBooks(getBookParams, pageable)
        );
        return ResponseEntity.ok(pagedModel);
    }
    @GetMapping("/read/new-book")
    ResponseEntity<PagedModel<EntityModel<BookDto>>> getBooksInUseNew(Pageable pageable){
        PagedModel<EntityModel<BookDto>> pagedModel = bookDtoPagedResourcesAssembler.toModel(
                bookService.getBooksInUseNew(pageable)
        );
        return ResponseEntity.ok(pagedModel);
    }

    @GetMapping("/read/nominated-book")
    ResponseEntity<PagedModel<EntityModel<BookDto>>> getBooksInUseNominated(Pageable pageable){
        PagedModel<EntityModel<BookDto>> pagedModel = bookDtoPagedResourcesAssembler.toModel(
                bookService.getBooksInUseNominated(pageable)
        );
        return ResponseEntity.ok(pagedModel);
    }

    @GetMapping("/read/{id}")
    ResponseEntity<BookDto> getBookById(@PathVariable("id") Long id){
        return ResponseEntity.ok(bookService.getBookById(id));
    }

    @GetMapping("/{id}")
    ResponseEntity<BookFullInfoDto> getFullInfoById(@PathVariable("id") Long id){
        return ResponseEntity.ok(bookService.getBookFullInfoById(id));
    }

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    ResponseEntity<BookDto> createBook(
            @RequestPart(name = "book") UpsertBookForm upsertBookForm,
            @RequestPart(name = "file", required = false)MultipartFile file
            ){
        return ResponseEntity.ok(bookService.createBook(upsertBookForm,file));
    }

    @PutMapping("/new/{id}")
    ResponseEntity<?> changeBookStatusToNew(
            @PathVariable(name = "id")  Long bookId
    ){
        bookService.changeBookStatusToNew(bookId);
        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @PutMapping("/nominated/{id}")
    ResponseEntity<?> changeBookStatusToNominated(
            @PathVariable(name = "id")  Long bookId
    ){
        bookService.changeBookStatusToNominated(bookId);
        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @PutMapping(value = "/{id}",consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    ResponseEntity<BookDto> updateBook(
            @PathVariable(name = "id")  Long bookId,
            @RequestPart(name = "book") @Valid UpsertBookForm upsertBookForm,
            @RequestPart(name = "file", required = false)MultipartFile file
    ) throws IOException {
        return ResponseEntity.ok(bookService.updateBook(bookId, upsertBookForm, file));
    }

    @DeleteMapping("/{id}")
    ResponseEntity<Object> deleteBook(@PathVariable(name = "id") Long bookId){
        return ResponseEntity.ok(bookService.deleteBook(bookId));
    }

    @DeleteMapping(path = "/delete-multiple", consumes = MediaType.APPLICATION_JSON_VALUE)
    ResponseEntity<Object> deleteMultipleBooks(@RequestBody List<Long> listBookIds){
        return ResponseEntity.ok(bookService.deleteMultipleBooks(listBookIds));
    }

    @GetMapping("/excel/export")
    public ResponseEntity<Object> export(HttpServletResponse response) throws IOException {
        String fileName = "Danh mục sách"  + ".xlsx";
        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=\"" + fileName + "\"";
        response.setHeader(headerKey, headerValue);
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();

        List<BookExcelDto> bookDtoList =
                bookService
                        .getBooksList(new GetBookParams());
        writeExcelService.writeExcelFile(bookDtoList, byteArrayOutputStream, BookExcelDto.class);
        byte[] bytes = byteArrayOutputStream.toByteArray();
        String encoding = Base64.getEncoder().encodeToString(bytes);
        return ResponseEntity.status(HttpStatus.OK).body(encoding);
    }

    @PutMapping(value = "/change-status", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> changeBookStatuses(List<Long> bookList, BookStatus status){
        bookService.changeListStatus(bookList, status);
        return ResponseEntity.status(HttpStatus.OK).body("success");
    }

    @PostMapping(path = "/excel/import", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    @Transactional
    public ResponseEntity<Object> importExcel(
            @RequestPart(name = "file")MultipartFile excelFile
    ) throws IOException {
        String excelPath = excelFile.getOriginalFilename();
        InputStream inputStream = excelFile.getInputStream();

            List<UpsertExcelBookForm> list = null;
            try {
                list = readExcelService.readExcelFile(inputStream, excelPath, UpsertExcelBookForm.class);
            } catch (IOException | InvocationTargetException | IllegalAccessException | InstantiationException |
                     NoSuchMethodException e) {
                throw new RuntimeException(e);
            }
            bookService.createMultipleBooks(list);

        return ResponseEntity.status(HttpStatus.OK).body("success");
    }
}
