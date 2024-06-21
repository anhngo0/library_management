package com.example.libraryManagement.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Entity
@Setter
@Getter
@NoArgsConstructor
@Table(name = "book_class_number", uniqueConstraints = @UniqueConstraint(columnNames = "name", name = "name"))
public class BookClassNumber {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)

    private Long id;
    @Column(nullable = false)
    private String name;
//    @OneToMany(targetEntity = Book.class, mappedBy = "classNumber")
//    List<Book> bookList;

}
