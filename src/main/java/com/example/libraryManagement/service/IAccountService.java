package com.example.libraryManagement.service;

import com.example.libraryManagement.model.dto.AccountDto;
import com.example.libraryManagement.model.dto.form.UpsertAccountForm;
import com.example.libraryManagement.model.dto.fullInfo.AccountFullInfoDto;
import com.example.libraryManagement.model.entity.Account;
import com.example.libraryManagement.model.entity.UserRole;
import com.example.libraryManagement.query.params.GetAccountParams;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;

import java.util.List;
import java.util.Optional;

public interface IAccountService {
    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    AccountDto createAccount(UpsertAccountForm upsertAccountForm);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN')")
    Page<AccountFullInfoDto> getAccountFullInfoDto(GetAccountParams getAccountParams, Pageable pageable);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    Page<AccountDto> getAccountDto(GetAccountParams getAccountParams, Pageable pageable);

//    AccountDto updateAccount(UpsertAccountForm upsertAccountForm, Long id);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    void deleteAccount(Long id);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN')")
    List<Long> getAccountIdByRole(UserRole userRole);

    void requestPasswordReset(String email);

    void completePasswordReset(String newPassword, String resetKey);
}
