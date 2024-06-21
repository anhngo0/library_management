package com.example.libraryManagement.mapper;

import com.example.libraryManagement.model.dto.NotificationDto;
import com.example.libraryManagement.model.entity.Notification;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public abstract class NotificationMapper {
    public abstract NotificationDto toDto(Notification notification);
}
