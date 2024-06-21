package com.example.libraryManagement.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Set;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "liquidation_ticket")
public class LiquidationTicket extends Ticket{

    private Double export_price;

    private int totalQuantity;

    @OneToMany(mappedBy = "liquidationTicket", targetEntity = Book.class, fetch = FetchType.LAZY)
    Set<Book> books;
}
