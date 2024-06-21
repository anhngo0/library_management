package com.example.libraryManagement.controller;

import com.example.libraryManagement.model.dto.ImportTicketDto;
import com.example.libraryManagement.model.dto.form.CreateImportTicketForm;
import com.example.libraryManagement.model.dto.form.RespondImportTicketForm;
import com.example.libraryManagement.model.dto.fullInfo.ImportTicketFullInfoDto;
import com.example.libraryManagement.query.params.GetImportTicketParams;
import com.example.libraryManagement.service.IImportTicketService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.PagedModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/api/v1/import-ticket")
@RequiredArgsConstructor
public class ImportTicketController {
    private final IImportTicketService importTicketService;
    private final PagedResourcesAssembler<ImportTicketDto> pagedResourcesAssembler;

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<ImportTicketDto> createImportTicket(
            @RequestPart("form")CreateImportTicketForm createImportTicketForm,
            @RequestPart(value = "file",  required = false) MultipartFile file
            ){
        return ResponseEntity.ok(importTicketService.createImportTicket(createImportTicketForm, file));
    }

    @GetMapping
    public ResponseEntity<PagedModel<EntityModel<ImportTicketDto>>> getImportTickets(
            GetImportTicketParams getImportTicketParams,
            Pageable pageable
    ){
        PagedModel<EntityModel<ImportTicketDto>> page = pagedResourcesAssembler.toModel(
                importTicketService.getImportTickets(getImportTicketParams, pageable)
        );
        return ResponseEntity.ok(page);
    }

    @GetMapping("/full-info/{id}")
    public ResponseEntity<ImportTicketFullInfoDto> getFullInfoById(@PathVariable("id") Long id){
        return ResponseEntity.ok(importTicketService.getImportTicketFullInfoById(id));
    }
    @PutMapping("/update/{id}")
    public ResponseEntity<ImportTicketDto> updateImportTicket(
            @PathVariable("id") Long id,
            @RequestPart("form") CreateImportTicketForm createImportTicketForm,
            @RequestPart(value = "file", required = false) MultipartFile file
    ){
        return ResponseEntity.ok(importTicketService.updateImportTicket(id, createImportTicketForm, file));
    }
    @PutMapping(value = "/respond/{id}", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<ImportTicketDto> respondImportTicket(@PathVariable("id") Long id, @RequestBody RespondImportTicketForm respondImportTicketForm){
        return ResponseEntity.ok(importTicketService.respondImportTicket(id, respondImportTicketForm));
    }

    @DeleteMapping(path = "/multiple")
    public ResponseEntity<Object> deleteMultipleImportTickets(@RequestBody List<Long> list) {
        importTicketService.deleteMultiple(list);
        return ResponseEntity.status(HttpStatus.OK).body("success");
    }

    @DeleteMapping(path = "/{id}")
    public ResponseEntity<Object> deleteMultipleImportTickets(@PathVariable("id") Long id) {
        importTicketService.deleteImporTicket(id);
        return ResponseEntity.status(HttpStatus.OK).body("success");
    }
}
