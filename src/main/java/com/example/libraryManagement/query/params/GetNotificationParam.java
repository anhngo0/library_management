package com.example.libraryManagement.query.params;

import lombok.Data;

import java.time.Instant;

@Data
public class GetNotificationParam {
    private Instant createFrom;
    private Instant createTo;
    private long associatedUserId;
}
