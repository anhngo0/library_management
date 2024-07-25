package com.example.libraryManagement.controller;

import com.example.libraryManagement.exeption.ResourceNotFoundException;
import com.example.libraryManagement.model.dto.AccountDto;
import com.example.libraryManagement.model.dto.form.ResetPasswordForm;
import com.example.libraryManagement.model.dto.form.UpsertAccountForm;
import com.example.libraryManagement.model.dto.fullInfo.AccountFullInfoDto;
import com.example.libraryManagement.model.entity.Account;
import com.example.libraryManagement.query.params.GetAccountParams;
import com.example.libraryManagement.service.IAccountService;
import com.example.libraryManagement.service.IMailService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.PagedModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Optional;

@RestController
@RequestMapping("/api/v1/account")
@RequiredArgsConstructor
public class AccountController {
    private final IAccountService accountService;

    private final Logger logger = LoggerFactory.getLogger(AccountController.class);
    private final PagedResourcesAssembler<AccountFullInfoDto> pagedResourcesAssembler;
    private final PagedResourcesAssembler<AccountDto> accountDtoPagedResourcesAssembler;

    @PostMapping(path = "/create-account", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<AccountDto> createAccount(@RequestBody UpsertAccountForm upsertAccountForm){
        return ResponseEntity.ok(accountService.createAccount(upsertAccountForm));
    }
    @GetMapping("/full-info")
    public ResponseEntity<PagedModel<EntityModel<AccountFullInfoDto>>> getFullInfoAccountDto(GetAccountParams getAccountParams, Pageable pageable){
        PagedModel<EntityModel<AccountFullInfoDto>> page = pagedResourcesAssembler.toModel(accountService.getAccountFullInfoDto(getAccountParams,pageable));
        return ResponseEntity.ok(page);
    }

    @GetMapping
    public ResponseEntity<PagedModel<EntityModel<AccountDto>>> getAccountDto(GetAccountParams getAccountParams, Pageable pageable){
        PagedModel<EntityModel<AccountDto>> page = accountDtoPagedResourcesAssembler.toModel(accountService.getAccountDto(getAccountParams,pageable));
        return ResponseEntity.ok(page);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteAccount( @PathVariable("id") Long id){
        accountService.deleteAccount(id);
        return ResponseEntity.status(HttpStatus.OK).body("delete success");
    }

    @PostMapping(path = "/account/reset-password/init")
    public void requestPasswordReset(@RequestParam(value = "email", required = true) String email) {
        logger.atInfo().log(email);
       accountService.requestPasswordReset(email);
    }

    //get the resetKey from the url
    @PostMapping(path = "/account/reset-password/finish")
    public void finishPasswordReset(@RequestBody ResetPasswordForm resetPasswordForm) {
         accountService.completePasswordReset(resetPasswordForm.getNewPassword(), resetPasswordForm.getResetKey());
    }


}
