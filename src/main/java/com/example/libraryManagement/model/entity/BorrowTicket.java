package com.example.libraryManagement.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.Set;

@Entity
@Getter
@Setter
@NoArgsConstructor
@NamedEntityGraph(name = "borrow_ticket",attributeNodes = {
        @NamedAttributeNode("librarian"),
        @NamedAttributeNode("member")
})
public class BorrowTicket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private LocalDateTime borrowed_date;
    private LocalDateTime returned_date;
    @Enumerated(EnumType.STRING)
    private TicketStatus status;
    private String note;

    @ManyToOne(targetEntity = Profile.class)
    @JoinColumn(name = "librarian_id", referencedColumnName = "id")
    private Profile librarian;

    @ManyToOne(targetEntity = Profile.class)
    @JoinColumn(name = "member_id", referencedColumnName = "id")
    private Profile member;

    @ManyToMany(targetEntity = Book.class, fetch = FetchType.LAZY)
    @JoinTable(
            name = "borrow_book",
            joinColumns = @JoinColumn(name ="book_id", referencedColumnName = "id"),
            inverseJoinColumns = @JoinColumn(name = "borrow_ticket_id", referencedColumnName = "id")
    )
    private Set<Book> books;

}
