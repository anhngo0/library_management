package com.example.libraryManagement.controller;

import com.example.libraryManagement.model.dto.NotificationDto;
import com.example.libraryManagement.query.params.GetNotificationParam;
import com.example.libraryManagement.service.INotificationService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/notification")
@RequiredArgsConstructor
public class NotificationController {
    private final INotificationService notificationService;

    @GetMapping("/list")
    public ResponseEntity<List<NotificationDto>> getListNotification(@RequestBody GetNotificationParam getNotificationParam){
        return ResponseEntity.ok(notificationService.getListNotification(getNotificationParam));
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> setReadNotificationStatus(@PathVariable("id") Long id){
        notificationService.setReadNotificationStatus(id);
        return ResponseEntity.status(HttpStatus.OK).body("success");
    }

    @DeleteMapping
    public ResponseEntity<?> deleteReadNotification(GetNotificationParam getNotificationParam){
        notificationService.deleteReadNotification(getNotificationParam);
        return ResponseEntity.status(HttpStatus.OK).body("success");
    }
}
