package com.example.libraryManagement.service.serviceImpl;

import com.example.libraryManagement.Utils.SecurityUtils;
import com.example.libraryManagement.exeption.ResourceNotFoundException;
import com.example.libraryManagement.mapper.LiquidationMapper;
import com.example.libraryManagement.model.dto.LiquidationTicketDto;
import com.example.libraryManagement.model.dto.form.CreateLiquidationTicketForm;
import com.example.libraryManagement.model.dto.form.RespondLiquidationTicketForm;
import com.example.libraryManagement.model.dto.fullInfo.LiquidationTicketFullInfoDto;
import com.example.libraryManagement.model.entity.*;
import com.example.libraryManagement.model.repository.LiquidationRepository;
import com.example.libraryManagement.query.params.GetLiquidationTicketParams;
import com.example.libraryManagement.query.predicate.LiquidationPredicate;
import com.example.libraryManagement.service.IBookService;
import com.example.libraryManagement.service.ILiquidationService;
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
import java.util.Set;
import java.util.concurrent.CompletableFuture;

@Service
@RequiredArgsConstructor
public class LiquidationServiceImpl implements ILiquidationService {
    private final LiquidationRepository liquidationRepository;
    private final LiquidationMapper liquidationMapper;
    private final INotificationService notificationService;
    private final FileStorageService fileStorageService;
    private final Logger logger = LoggerFactory.getLogger(LiquidationServiceImpl.class);
    private final IBookService bookService;

    @Override
    @Transactional
    public LiquidationTicketDto createLiquidationTicket(CreateLiquidationTicketForm createLiquidationTicketForm, MultipartFile attachments) {
        LiquidationTicket liquidationTicket = liquidationMapper.toEntity_create(createLiquidationTicketForm);
        if(SecurityUtils.getCurrentLoggedInUser().isPresent()){
            Account account = (Account) SecurityUtils.getCurrentLoggedInUser().get();
            Profile profile = account.getProfile();

            liquidationTicket.setCreator(profile);
            //in case the manager create the ticket
            if (profile.getUserRole().equals(UserRole.MANAGER)) {
                liquidationTicket.setStatus(TicketStatus.ACCEPT);
                liquidationTicket.setApprover(profile);
                liquidationTicket.setApproval_date(LocalDateTime.now());
            }

            liquidationTicket = liquidationRepository.save(liquidationTicket);
            LiquidationTicket newTicket = liquidationTicket;

            //in case the librarian create the ticket
            if(profile.getUserRole().equals(UserRole.LIBRARIAN)){
                notificationService.createNewNotification(
                        "A liquid ticket has created. Need to respond",
                        LiquidationTicket.class.getSimpleName(),
                        liquidationTicket.getId(), UserRole.MANAGER
                );
            }

            if(attachments != null ){
                CompletableFuture.runAsync(()-> {
                    fileStorageService.uploadMultipleFiles(
                            newTicket.getId(),
                            LiquidationTicket.class.getSimpleName(),
                            FileDescription.DOCUMENT,
                            attachments
                    );
                });
            }
        }
        return liquidationMapper.toDto(liquidationTicket);
    }

    @Override
    public Page<LiquidationTicketDto> getLiquidationTickets(GetLiquidationTicketParams getLiquidationTicketParams, Pageable pageable) {
        return liquidationRepository
                .findAll(LiquidationPredicate.getLiquidationTickets(getLiquidationTicketParams),pageable)
                .map(liquidationMapper::toDto);
    }

    @Override
    public LiquidationTicketFullInfoDto getFullInfoById(Long id) {
        LiquidationTicket liquidationTicket = liquidationRepository.findById(id).orElseThrow(()->new ResourceNotFoundException("resource not found"));
        return liquidationMapper.toFullInfoDto(liquidationTicket);
    }

    @Override
    public LiquidationTicketDto updateLiquidationTicket(Long id, CreateLiquidationTicketForm createLiquidationTicketForm, MultipartFile attachments) {
        LiquidationTicket liquidationTicket = liquidationRepository.findById(id).orElseThrow(()->new ResourceNotFoundException("resource not found"));
        LiquidationTicket updateTicket = liquidationMapper.toEntity_update(createLiquidationTicketForm,liquidationTicket);
        updateTicket = liquidationRepository.save(updateTicket);

        if(attachments != null){
            CompletableFuture.runAsync(()->{
                fileStorageService.deleteAllFilesOfAnEntity(LiquidationTicket.class.getSimpleName(), id, FileDescription.DOCUMENT);
                fileStorageService.uploadMultipleFiles(
                        id,
                        LiquidationTicket.class.getSimpleName(),
                        FileDescription.DOCUMENT,
                        attachments
                );
            });
        }
        return liquidationMapper.toDto(updateTicket);
    }

    @Override
    public void deleteLiquidationTicket(Long id) throws ResourceNotFoundException {
        liquidationRepository.deleteById(id);
        fileStorageService.deleteAllFilesOfAnEntity(LiquidationTicket.class.getSimpleName(), id, FileDescription.DOCUMENT);
    }

    @Override
    public void respondLiquidationTicketForm(Long id,RespondLiquidationTicketForm respondLiquidationTicketForm) {
        LiquidationTicket liquidationTicket = liquidationRepository.findById(id).orElseThrow(()-> new ResourceNotFoundException("resource not found"));
        liquidationTicket = liquidationMapper.toEntity_response(respondLiquidationTicketForm,liquidationTicket);
        liquidationTicket.setStatus(respondLiquidationTicketForm.getIsAccepted()?TicketStatus.ACCEPT:TicketStatus.REJECT);
        if(SecurityUtils.getCurrentLoggedInUser().isPresent()){
            Account account = (Account) SecurityUtils.getCurrentLoggedInUser().get();
            liquidationTicket.setApprover(account.getProfile());
        }
        liquidationTicket = liquidationRepository.save(liquidationTicket);
        if (respondLiquidationTicketForm.getIsAccepted()) {
            bookService.setBookState(liquidationTicket.getBooks(), BookStatus.LIQUIDATED);
        }

        notificationService.createNewNotification(
                "your created ticket has been responded",
                ImportTicket.class.getSimpleName(),
                liquidationTicket.getId(), UserRole.LIBRARIAN

        );
    }

    @Override
    public void deleteMultiple(List<Long> ids) {
        try {
            liquidationRepository.deleteAllById(ids);
        } catch (RuntimeException e){
         logger.atInfo().log(e.getMessage());
        }
    }


}
