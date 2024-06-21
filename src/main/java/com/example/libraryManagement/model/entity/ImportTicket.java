package com.example.libraryManagement.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class ImportTicket extends Ticket{
    private Integer totalQuantity;
    private Double totalPrice;
    private String supplier;
    private String import_way;
}
