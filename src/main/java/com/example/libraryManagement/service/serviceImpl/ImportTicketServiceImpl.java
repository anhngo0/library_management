package com.example.libraryManagement.service.serviceImpl;

import com.example.libraryManagement.Utils.SecurityUtils;
import com.example.libraryManagement.exeption.ResourceNotFoundException;
import com.example.libraryManagement.mapper.ImportTicketMapper;
import com.example.libraryManagement.model.dto.ImportTicketDto;
import com.example.libraryManagement.model.dto.form.CreateImportTicketForm;
import com.example.libraryManagement.model.dto.form.RespondImportTicketForm;
import com.example.libraryManagement.model.dto.fullInfo.ImportTicketFullInfoDto;
import com.example.libraryManagement.model.entity.*;
import com.example.libraryManagement.model.repository.ImportTicketRepository;
import com.example.libraryManagement.query.params.GetImportTicketParams;
import com.example.libraryManagement.query.predicate.ImportTicketPredicate;
import com.example.libraryManagement.service.IImportTicketService;
import com.example.libraryManagement.service.INotificationService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDateTime;
import java.util.List;
import java.util.concurrent.CompletableFuture;

@Service
@RequiredArgsConstructor
public class ImportTicketServiceImpl implements IImportTicketService {
    private final ImportTicketRepository importTicketRepository;
    private final ImportTicketMapper importTicketMapper;
    private final FileStorageService fileStorageService;
    private final Logger logger = LoggerFactory.getLogger(ImportTicketServiceImpl.class);
    private final INotificationService notificationService;

    @Override
    @Transactional
    public ImportTicketDto createImportTicket(CreateImportTicketForm createImportTicketForm, MultipartFile file) {
        ImportTicket importTicket = importTicketMapper.toEntity_create(createImportTicketForm);
        if(SecurityUtils.getCurrentLoggedInUser().isPresent()){
            Account account = (Account) SecurityUtils.getCurrentLoggedInUser().get();
            Profile profile = account.getProfile();

            importTicket.setCreator(profile);
            // in case the manager create the ticket
            if(profile.getUserRole().equals(UserRole.MANAGER)){
                importTicket.setStatus(TicketStatus.ACCEPT);
                importTicket.setApprover(profile);
                importTicket.setApproval_date(LocalDateTime.now());
            }

            importTicket = importTicketRepository.save(importTicket);
            ImportTicket ticket = importTicket;

            if(profile.getUserRole().equals(UserRole.LIBRARIAN)){
                notificationService.createNewNotification(
                        "An import ticket has created. Need to respond",
                        ImportTicket.class.getSimpleName(),
                        importTicket.getId(), UserRole.MANAGER

                );
            }

            CompletableFuture.runAsync(()-> {
                fileStorageService.uploadMultipleFiles(
                        ticket.getId(),
                        ImportTicket.class.getSimpleName(),
                        FileDescription.DOCUMENT,
                        file
                );
            });
        }
        return importTicketMapper.toDto(importTicket);
    }

    @Override
    public Page<ImportTicketDto> getImportTickets(GetImportTicketParams getImportTicketParams, Pageable pageable) {
        return importTicketRepository.findAll(ImportTicketPredicate.getImportTickets(getImportTicketParams), pageable)
                .map(importTicketMapper::toDto);
    }

    @Override
    public ImportTicketFullInfoDto getImportTicketFullInfoById(Long id) {
        ImportTicket importTicket = importTicketRepository.findById(id)
                .orElseThrow(()-> new ResourceNotFoundException("resource not found"));
        return importTicketMapper.toFullInfoDto(importTicket);
    }

    @Override
    public ImportTicketDto updateImportTicket(Long id, CreateImportTicketForm createImportTicketForm, MultipartFile file) {
        ImportTicket importTicket = importTicketRepository.findById(id).orElseThrow(()-> new ResourceNotFoundException("resource not found"));
        importTicket=importTicketMapper.toEntity_update(createImportTicketForm, importTicket);
        importTicketRepository.save(importTicket);
        ImportTicket finalImportTicket = importTicket;
        if(file!=null){
           CompletableFuture.runAsync(()-> {
             fileStorageService.deleteAllFilesOfAnEntity(
                     ImportTicket.class.getSimpleName(),
                     finalImportTicket.getId(),
                     FileDescription.DOCUMENT
             );
             fileStorageService.uploadMultipleFiles(
                     finalImportTicket.getId(),
                     ImportTicket.class.getSimpleName(),
                     FileDescription.DOCUMENT,
                     file
             );
           });
       }
        return importTicketMapper.toDto(importTicket);
    }

    @Override
    @Transactional
    public ImportTicketDto respondImportTicket(Long id, RespondImportTicketForm respondImportTicketForm) {

        ImportTicket importTicket = importTicketRepository.findById(id).orElseThrow(()-> new ResourceNotFoundException("resource not found"));
        importTicket = importTicketMapper.toEntity_response(respondImportTicketForm, importTicket);
        importTicket.setStatus(respondImportTicketForm.getIsAccepted() ? TicketStatus.ACCEPT:TicketStatus.REJECT);
        if(SecurityUtils.getCurrentLoggedInUser().isPresent()){
            Account account = (Account) SecurityUtils.getCurrentLoggedInUser().get();
            importTicket.setApprover(account.getProfile());
        }
        importTicket = importTicketRepository.save(importTicket);
        notificationService.createNewNotification(
                "your created ticket has been responded",
                ImportTicket.class.getSimpleName(),
                importTicket.getId(), UserRole.LIBRARIAN

        );

        return importTicketMapper.toDto(importTicket);
    }

    @Override
    @Transactional
    public void deleteMultiple(List<Long> list) {
        try {
            importTicketRepository.deleteAllById(list);
        } catch (RuntimeException e){
            logger.atInfo().log(e.getMessage());
        }
    }

    @Override
    public void deleteImporTicket(Long id) {
        try {
            importTicketRepository.deleteById(id);
        } catch (RuntimeException e){
            logger.atInfo().log(e.getMessage());
        }
    }
}
