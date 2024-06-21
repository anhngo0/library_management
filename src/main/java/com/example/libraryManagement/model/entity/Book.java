package com.example.libraryManagement.model.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigInteger;
import java.time.Year;
import java.util.Set;

@Entity
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@NamedEntityGraph(
        name = "BookFullInfo" , attributeNodes =
        {
                @NamedAttributeNode("category"),
                @NamedAttributeNode("classNumber"),
                @NamedAttributeNode(value = "liquidationTicket", subgraph = "ticket_subgraph")
      }, subgraphs = {
                @NamedSubgraph(
                        name="ticket_subgraph",
                        attributeNodes = {@NamedAttributeNode("creator"), @NamedAttributeNode("approver")}
                )
}
)
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String titleName;
    private String alterName;
    @Column(name = "isbn_number")
    private String ISBNNumber;
    private String author;
    private String bookPosition;
    private Double price;
    private int quantity;
    private Year year_of_publication;
    private String publisher;
    private String language;
    private String description;
    @Column(name = "is_Borrowed")
    private boolean isBorrowed = false;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private BookStatus status;

    @ManyToOne(targetEntity = BookCategory.class)
    @JoinColumn(name = "category_id")
    private BookCategory category;

    @ManyToOne(targetEntity = BookClassNumber.class)
    @JoinColumn(name = "number_id")
    private BookClassNumber classNumber;

    @ManyToOne(targetEntity = LiquidationTicket.class)
    @JoinColumn(name = "liquidation_ticket_id", referencedColumnName = "id")
    private LiquidationTicket liquidationTicket;

    @ManyToMany(mappedBy = "books",fetch = FetchType.LAZY, targetEntity = BorrowTicket.class)
    Set<BorrowTicket> borrowTickets;

}
