package com.example.libraryManagement.model.repository;

import com.example.libraryManagement.model.entity.Account;
import org.springframework.data.jpa.repository.Query;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AccountRepository extends ParentRepository<Account,Long> {
    Optional<UserDetails> findByUsername(String username);

    Optional<Account> findOneByResetKey(String resetKey);

    @Query("SELECT a FROM Account a JOIN a.profile p WHERE LOWER(p.email) = LOWER(:email)")
    Optional<Account> findOneByProfileEmailIgnoreCase(String email);
}
