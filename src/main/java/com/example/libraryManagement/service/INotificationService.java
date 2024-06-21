package com.example.libraryManagement.service;

import com.example.libraryManagement.model.dto.NotificationDto;
import com.example.libraryManagement.model.entity.Notification;
import com.example.libraryManagement.model.entity.UserRole;
import com.example.libraryManagement.query.params.GetNotificationParam;

import java.util.List;

public interface INotificationService {
    List<NotificationDto> getListNotification(GetNotificationParam getNotificationParam);

    void createNewNotification(
            String content, String associatedEntityType,
            Long associatedEntityId, UserRole userRole
            );

    void setReadNotificationStatus(Long id);

    void deleteReadNotification(GetNotificationParam getNotificationParam);
}
