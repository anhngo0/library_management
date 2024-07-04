package com.example.libraryManagement.model.dto;

import lombok.Data;

import java.io.Serializable;
import java.time.Instant;

@Data
public class NotificationDto  {
    private Long id;
    private String content;
    private Instant createdAt;
    private boolean isRead;
    private String associatedEntityType;
    private Long associatedEntityId;
    private Long associatedUserId;
}
