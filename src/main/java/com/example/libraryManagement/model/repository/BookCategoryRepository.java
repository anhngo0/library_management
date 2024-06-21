package com.example.libraryManagement.model.repository;

import com.example.libraryManagement.model.entity.BookCategory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface BookCategoryRepository extends ParentRepository<BookCategory, Long> {
    Optional<BookCategory> findByName(String category);
}
