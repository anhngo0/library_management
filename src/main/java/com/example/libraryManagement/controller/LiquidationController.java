package com.example.libraryManagement.controller;

import com.example.libraryManagement.model.dto.BookDto;
import com.example.libraryManagement.model.dto.LiquidationTicketDto;
import com.example.libraryManagement.model.dto.form.CreateLiquidationTicketForm;
import com.example.libraryManagement.model.dto.form.RespondLiquidationTicketForm;
import com.example.libraryManagement.model.dto.fullInfo.LiquidationTicketFullInfoDto;
import com.example.libraryManagement.query.params.GetLiquidationTicketParams;
import com.example.libraryManagement.service.ILiquidationService;
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
@RequestMapping("/api/v1/liquidation_ticket")
@RequiredArgsConstructor
public class LiquidationController {
    private final ILiquidationService liquidationService;
    private final PagedResourcesAssembler<LiquidationTicketDto> pagedResourcesAssembler;
    private final PagedResourcesAssembler<BookDto> bookDtoPagedResourcesAssembler;

    @PostMapping(consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<LiquidationTicketDto> createLiquidationTicket(
            @RequestPart("form")CreateLiquidationTicketForm createLiquidationTicketForm,
            @RequestPart(value = "file", required = false) MultipartFile attachments
            ){
        return ResponseEntity.ok(liquidationService.createLiquidationTicket(createLiquidationTicketForm, attachments));
    }

    //API GET LIST
    @GetMapping
    public ResponseEntity<PagedModel<EntityModel<LiquidationTicketDto>>> getLiquidationTickets(
            GetLiquidationTicketParams getLiquidationTicketParams, Pageable pageable
    ){
        PagedModel<EntityModel<LiquidationTicketDto>> page = pagedResourcesAssembler.toModel(liquidationService.getLiquidationTickets(getLiquidationTicketParams,pageable));
        return ResponseEntity.ok(page);
    }

    @GetMapping("/full-info/{id}")
    public ResponseEntity<LiquidationTicketFullInfoDto> getFullInfoById(@PathVariable("id") Long id){
        return ResponseEntity.ok(liquidationService.getFullInfoById(id));
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<LiquidationTicketDto> updateLiquidationTicket(
            @PathVariable("id") Long id,
            @RequestPart("form")CreateLiquidationTicketForm createLiquidationTicketForm,
            @RequestPart(value = "file", required = false) MultipartFile attachments

    ){
        return ResponseEntity.ok(liquidationService.updateLiquidationTicket(id, createLiquidationTicketForm, attachments));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteLiquidationTicket(@PathVariable("id") Long id){
        liquidationService.deleteLiquidationTicket(id);
        return ResponseEntity.status(HttpStatus.OK).body("delete success");
    }

    @DeleteMapping("/multiple")
    public ResponseEntity<?> deleteMultiple(@RequestBody List<Long> ids){
        liquidationService.deleteMultiple(ids);
        return ResponseEntity.status(HttpStatus.OK).body("delete success");
    }

    @PutMapping(value = "/respond/{id}",consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> responseLiquidationTicket(@PathVariable("id") Long id, RespondLiquidationTicketForm respondLiquidationTicketForm){
        liquidationService.respondLiquidationTicketForm(id,respondLiquidationTicketForm);
        return ResponseEntity.status(HttpStatus.OK).body("call success");
    }

}
