package com.example.libraryManagement.service.serviceImpl;

import com.example.libraryManagement.Utils.SecurityUtils;
import com.example.libraryManagement.exeption.ResourceNotFoundException;
import com.example.libraryManagement.mapper.BorrowTicketMapper;
import com.example.libraryManagement.model.dto.BorrowTicketDto;
import com.example.libraryManagement.model.dto.form.AcceptBorrowTicketForm;
import com.example.libraryManagement.model.dto.form.CreateBorrowTicketForm;
import com.example.libraryManagement.model.dto.fullInfo.BorrowTicketFullInfoDto;
import com.example.libraryManagement.model.entity.Account;
import com.example.libraryManagement.model.entity.BorrowTicket;
import com.example.libraryManagement.model.repository.BorrowedTicketRepository;
import com.example.libraryManagement.query.params.GetBorrowTicketParams;
import com.example.libraryManagement.query.predicate.BookPredicate;
import com.example.libraryManagement.query.predicate.BorrowTicketPredicate;
import com.example.libraryManagement.service.IBookService;
import com.example.libraryManagement.service.IBorrowedTicketService;
import com.querydsl.core.types.Predicate;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BorrowedTicketServiceImpl implements IBorrowedTicketService {
    private final BorrowedTicketRepository borrowedTicketRepository;
    private final BorrowTicketMapper borrowTicketMapper;
    private final IBookService bookService;

    @Override
    public Page<BorrowTicketDto> getBorrowedTickets(GetBorrowTicketParams getBorrowTicketParams, Pageable pageable) {
        return borrowedTicketRepository
                .findAll( BorrowTicketPredicate.getBorrowedTickets(getBorrowTicketParams), pageable)
                .map(borrowTicketMapper::toDto);
    }

    @Override
    public BorrowTicketFullInfoDto getBorrowedTicketFullInfo(Long id) {
        BorrowTicket ticket = borrowedTicketRepository.findById(id).orElseThrow(()-> new ResourceNotFoundException("resource not found"));
        return borrowTicketMapper.toFullInfoDto(ticket);
    }

    @Override
    public BorrowTicketDto updateBorrowedTicket(Long id, CreateBorrowTicketForm createBorrowTicketForm) {
        BorrowTicket ticket = borrowedTicketRepository.findById(id).orElseThrow(()-> new ResourceNotFoundException("resource not found"));
        ticket = borrowTicketMapper.toEntity_update(createBorrowTicketForm,ticket);
        ticket = borrowedTicketRepository.save(ticket);
        return borrowTicketMapper.toDto(ticket);
    }

    @Override
    public void deleteBorrowedTicket(Long id) throws ResourceNotFoundException, RuntimeException {
        borrowedTicketRepository.deleteById(id);
    }

    @Override
    public BorrowTicketDto respondBorrowedTicket(Long id, AcceptBorrowTicketForm acceptBorrowTicketForm) {
        BorrowTicket borrowTicket = borrowedTicketRepository.findById(id).orElseThrow(()-> new ResourceNotFoundException("resource not found"));
        borrowTicket = borrowTicketMapper.toEntity_accept(acceptBorrowTicketForm, borrowTicket);
        bookService.setBookIsBorrowedState(borrowTicket.getBooks(), false);
        borrowTicket = borrowedTicketRepository.save(borrowTicket);
        return borrowTicketMapper.toDto(borrowTicket);
    }

    @Override
    public BorrowTicketDto createBorrowedTicket(CreateBorrowTicketForm createBorrowTicketForm) {
        BorrowTicket ticket = borrowTicketMapper.toEntity_create(createBorrowTicketForm);
        bookService.setBookIsBorrowedState(ticket.getBooks(), true);
        if(SecurityUtils.getCurrentLoggedInUser().isPresent()){
            Account account = (Account) SecurityUtils.getCurrentLoggedInUser().get();
            ticket.setLibrarian(account.getProfile());
        }
         ticket = borrowedTicketRepository.save(ticket);
         return borrowTicketMapper.toDto(ticket);
    }
}
