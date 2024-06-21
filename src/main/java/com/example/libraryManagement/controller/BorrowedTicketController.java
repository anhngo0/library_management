package com.example.libraryManagement.controller;

import com.example.libraryManagement.model.dto.BorrowTicketDto;
import com.example.libraryManagement.model.dto.form.AcceptBorrowTicketForm;
import com.example.libraryManagement.model.dto.form.CreateBorrowTicketForm;
import com.example.libraryManagement.model.dto.fullInfo.BorrowTicketFullInfoDto;
import com.example.libraryManagement.query.params.GetBorrowTicketParams;
import com.example.libraryManagement.service.IBorrowedTicketService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.PagedModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/borrowed-ticket")
@RequiredArgsConstructor
public class BorrowedTicketController {
    private final IBorrowedTicketService borrowedTicketService;
    private final PagedResourcesAssembler<BorrowTicketDto> pagedResourcesAssembler;

    @PostMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<BorrowTicketDto> createBorrowedTicket(@RequestBody CreateBorrowTicketForm createBorrowTicketForm){
        return ResponseEntity.ok(borrowedTicketService.createBorrowedTicket(createBorrowTicketForm));
    }

    @GetMapping
    public ResponseEntity<PagedModel<EntityModel<BorrowTicketDto>>> getBorrowedTickets(
            GetBorrowTicketParams getBorrowTicketParams,
            Pageable pageable
    ){
        PagedModel<EntityModel<BorrowTicketDto>> pagedModel = pagedResourcesAssembler.toModel(
                borrowedTicketService.getBorrowedTickets(getBorrowTicketParams, pageable)
        );
        return ResponseEntity.ok(pagedModel);
    }

    @GetMapping("/full-info/{id}")
    public ResponseEntity<BorrowTicketFullInfoDto> getBorrowedTicketsFullInfoById(@PathVariable("id") Long id){
        return ResponseEntity.ok(borrowedTicketService.getBorrowedTicketFullInfo(id));
    }

    @PutMapping("/{id}")
    public ResponseEntity<BorrowTicketDto> updateBorrowedTicket(@PathVariable("id") Long id, CreateBorrowTicketForm createBorrowTicketForm){
        return ResponseEntity.ok(borrowedTicketService.updateBorrowedTicket(id,createBorrowTicketForm));
    }

    @PutMapping("respond/{id}")
    public ResponseEntity<BorrowTicketDto> respondBorrowedTicket(@PathVariable("id") Long id, AcceptBorrowTicketForm acceptBorrowTicketForm){
        return ResponseEntity.ok(borrowedTicketService.respondBorrowedTicket(id,acceptBorrowTicketForm));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteBorrowedTicket(@PathVariable("id") Long id){
        borrowedTicketService.deleteBorrowedTicket(id);
        return ResponseEntity.status(HttpStatus.OK).body("delete success");
    }



}
