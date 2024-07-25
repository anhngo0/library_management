package com.example.libraryManagement.model.repository;

import com.example.libraryManagement.model.entity.Account;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@Repository
public interface AccountRepository extends ParentRepository<Account,Long> {
    Optional<UserDetails> findByUsername(String username);

    Optional<Account> findOneByResetKey(String resetKey);

    @Query("SELECT a FROM Account a WHERE LOWER(a.profile.email) = LOWER(:email)")
    Optional<Account> findOneByProfileEmailIgnoreCase(@Param("email") String email);
}
