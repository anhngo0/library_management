package com.example.libraryManagement.model.repository;

import com.example.libraryManagement.model.entity.BookCategory;
import com.example.libraryManagement.model.entity.BookClassNumber;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface BookClassNumberRepository extends ParentRepository<BookClassNumber, Long> {
    Optional<BookClassNumber> findByName(String bookClassNumber);
}
