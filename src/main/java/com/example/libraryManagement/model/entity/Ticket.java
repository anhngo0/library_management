package com.example.libraryManagement.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@MappedSuperclass
@Getter
@Setter
public class Ticket {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    protected Long id;
    protected LocalDateTime created_date;
    protected LocalDateTime approval_date;
    protected String creator_note;
    protected String approver_note;

    @Enumerated(EnumType.STRING)
    protected TicketStatus status;
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "creator_id", referencedColumnName = "id")
    protected Profile creator;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "approver_id", referencedColumnName = "id")
    protected Profile approver;

}
