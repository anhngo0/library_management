package com.example.libraryManagement.service.serviceImpl;

import com.example.libraryManagement.exeption.ResourceNotFoundException;
import com.example.libraryManagement.mapper.AccountMapper;
import com.example.libraryManagement.model.dto.AccountDto;
import com.example.libraryManagement.model.dto.form.UpsertAccountForm;
import com.example.libraryManagement.model.dto.fullInfo.AccountFullInfoDto;
import com.example.libraryManagement.model.entity.Account;
import com.example.libraryManagement.model.entity.UserRole;
import com.example.libraryManagement.model.repository.AccountRepository;
import com.example.libraryManagement.query.params.GetAccountParams;
import com.example.libraryManagement.query.predicate.AccountPredicate;
import com.example.libraryManagement.service.IAccountService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.random.RandomGenerator;

@Service
@RequiredArgsConstructor
public class AccountServiceImpl implements IAccountService {
    private final AccountRepository accountRepository;
    private final AccountMapper accountMapper;
    private final Logger logger = LoggerFactory.getLogger(AccountServiceImpl.class);
    private final PasswordEncoder passwordEncoder;

    @Override
    public AccountDto createAccount(UpsertAccountForm upsertAccountForm) {
        Account account = accountMapper.toEntity(upsertAccountForm);
        logger.atInfo().log(account.getUsername());
        account = accountRepository.save(account);
        return accountMapper.toDto(account);
    }

    @Override
    public Page<AccountFullInfoDto> getAccountFullInfoDto(GetAccountParams getAccountParams, Pageable pageable) {
        return accountRepository
                .findAll(AccountPredicate.getAccounts(getAccountParams), pageable)
                .map(accountMapper::toFullInfoDto);
    }

    @Override
    public Page<AccountDto> getAccountDto(GetAccountParams getAccountParams, Pageable pageable) {
        return null;
    }

    @Override
    public void deleteAccount(Long id) throws ResourceNotFoundException {
           accountRepository.deleteById(id);
    }

    @Override
    public List<Long> getAccountIdByRole(UserRole userRole){
        List<Long> accountIdList = new ArrayList<Long>();
        accountRepository.findAll(AccountPredicate.findByProfileRole(userRole)).forEach(
                account -> {
                    logger.atInfo().log(String.valueOf(account));
                    logger.atInfo().log(String.valueOf(account.getId()));
                    accountIdList.add(account.getId());
                }
        );
        return accountIdList;
    }

    @Override
    public Optional<Account> requestPasswordReset(String mail) {
        return accountRepository
                .findOneByProfileEmailIgnoreCase(mail)
                .map(user -> {
                    user.setResetKey(UUID.randomUUID().toString());
                    user.setResetDate(Instant.now());
                    return user;
                });
    }

    /*find account by reset key and check if the request has expired after 15 minutes or not*/
    @Override
    public void completePasswordReset(String newPassword, String resetKey) {
        Optional<Account>  account = accountRepository
                .findOneByResetKey(resetKey)
                .filter(user -> user.getResetDate().isAfter(Instant.now().minus(15, ChronoUnit.MINUTES)))
                .map(user -> {
                    user.setPassword(passwordEncoder.encode(newPassword));
                    user.setResetKey(null);
                    user.setResetDate(null);
                    return user;
                });
        if (account.isEmpty()) {
            throw new ResourceNotFoundException("No user was found for this reset key");
        }
        accountRepository.save(account.get());
    }
}
