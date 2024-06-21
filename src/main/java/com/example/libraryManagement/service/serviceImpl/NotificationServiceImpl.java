package com.example.libraryManagement.service.serviceImpl;

import com.example.libraryManagement.exeption.ResourceNotFoundException;
import com.example.libraryManagement.mapper.NotificationMapper;
import com.example.libraryManagement.model.dto.NotificationDto;
import com.example.libraryManagement.model.entity.Account;
import com.example.libraryManagement.model.entity.Notification;
import com.example.libraryManagement.model.entity.UserRole;
import com.example.libraryManagement.model.repository.NotificationRepository;
import com.example.libraryManagement.query.params.GetNotificationParam;
import com.example.libraryManagement.query.predicate.NotificationPredicate;
import com.example.libraryManagement.service.IAccountService;
import com.example.libraryManagement.service.INotificationService;
import lombok.RequiredArgsConstructor;
import org.apache.catalina.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class NotificationServiceImpl implements INotificationService {
    private final NotificationMapper notificationMapper;
    private final NotificationRepository notificationRepository;
    private final Logger logger = LoggerFactory.getLogger(NotificationServiceImpl.class);
    private final IAccountService accountService;

    @Override
    public List<NotificationDto> getListNotification(GetNotificationParam getNotificationParam) {
        List<NotificationDto> notificationDtos = new ArrayList<NotificationDto>();
        notificationRepository
                .findAll(NotificationPredicate.getNotification(getNotificationParam))
                .forEach(notification -> notificationDtos.add(notificationMapper.toDto(notification)));
        return notificationDtos;
    }


    @Override
    public void createNewNotification(
            String content, String associatedEntityType,
            Long associatedEntityId, UserRole userRole
    ){
        List<Long> listId = accountService.getAccountIdByRole(userRole);
        List<Notification> notificationList = new ArrayList<Notification>();
        listId.forEach(
                id -> {
                    logger.atInfo().log(String.valueOf(id));
                    Notification notification = new Notification();
                    notification.setIsRead(Boolean.FALSE);
                    notification.setCreatedAt(Instant.now());
                    notification.setContent(content);
                    notification.setAssociatedUserId(id);
                    notification.setAssociatedEntityId(associatedEntityId);
                    notification.setAssociatedEntityType(associatedEntityType);
                    notificationList.add(notification);
                }
        );
        notificationRepository.saveAll(notificationList);
    }

    @Override
    public void setReadNotificationStatus(Long id) {
        Notification notification = notificationRepository.findById(id).orElseThrow(()-> new ResourceNotFoundException("resource not found"));
        notification.setIsRead(true);
        notificationRepository.save(notification);
    }

    @Override
    public void deleteReadNotification(GetNotificationParam getNotificationParam) {
        List<Notification> notificationList = new ArrayList<Notification>();
        notificationRepository.findAll(NotificationPredicate.getNotification(getNotificationParam)).forEach(
                notification -> {
                    if (notification.getIsRead()) notificationList.add(notification);
                }
        );
        notificationRepository.deleteAll(notificationList);
    }
}
