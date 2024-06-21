package com.example.libraryManagement.model.repository;

import com.example.libraryManagement.model.entity.LiquidationTicket;
import org.springframework.stereotype.Repository;

@Repository
public interface LiquidationRepository extends ParentRepository<LiquidationTicket, Long> {
}
