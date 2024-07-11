package com.example.libraryManagement.model.repository;

import com.example.libraryManagement.model.entity.Book;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface BookRepository extends ParentRepository<Book,Long> , PagingAndSortingRepository<Book, Long> {
    @Query("SELECT b FROM Book b WHERE b.status = 'IN_USE_NOMINATED'")
    Page<Book> findAllStatusNominated(Pageable pageable);
}
