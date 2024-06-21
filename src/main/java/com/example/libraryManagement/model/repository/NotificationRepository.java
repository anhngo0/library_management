package com.example.libraryManagement.model.repository;

import com.example.libraryManagement.model.entity.Notification;
import org.springframework.stereotype.Repository;

@Repository
public interface NotificationRepository extends ParentRepository<Notification, Long>{
}
