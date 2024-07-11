package com.example.libraryManagement.controller;


import com.example.libraryManagement.model.dto.FileStorageDto;
import com.example.libraryManagement.model.entity.Book;
import com.example.libraryManagement.model.entity.FileDescription;
import com.example.libraryManagement.model.entity.FileStorage;
import com.example.libraryManagement.service.IFileStorageService;
import org.apache.tomcat.util.file.ConfigurationSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/v1/file")
public class FileStorageController {
    @Autowired
    private IFileStorageService storageService;

    @GetMapping("/image/{id}")
    public ResponseEntity<?> getImgById(@PathVariable("id") Long id){
        FileStorage file = storageService.getImgById(id);
        return ResponseEntity.status(HttpStatus.OK).body(file);
    }

    @GetMapping("/document/{id}")
    public ResponseEntity<?> getDocumentById(@PathVariable("id") Long id){
        FileStorage file = storageService.getDocumentById(id);
        return ResponseEntity.status(HttpStatus.OK).body(file);
    }

    //Call api get here
    @GetMapping("/book-image/{id}")
    public ResponseEntity<?> getBookImages(@PathVariable("id") Long bookId){

        List<FileStorageDto> files = storageService.getAllFilesOfAnEntity(Book.class.getSimpleName(), bookId, FileDescription.IMAGE);
        return ResponseEntity.status(HttpStatus.OK).body(files);
    }
}
