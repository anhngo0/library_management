package com.example.libraryManagement.query.predicate;

import com.example.libraryManagement.model.entity.QNotification;
import com.example.libraryManagement.query.params.GetNotificationParam;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.dsl.BooleanExpression;
import org.apache.commons.lang3.ObjectUtils;

import java.time.Instant;

public class NotificationPredicate {
    private static final QNotification notification = QNotification.notification;
    public static BooleanBuilder getNotification(GetNotificationParam getNotificationParam){
        BooleanBuilder where = new BooleanBuilder();
        return where.and(matchUserId(getNotificationParam.getAssociatedUserId()))
                .and(createdBefore(getNotificationParam.getCreateTo()))
                .and(createdAfter(getNotificationParam.getCreateFrom()));
    }
    private static BooleanExpression matchUserId(Long userId){
        return ObjectUtils.isNotEmpty(userId) ? notification.associatedUserId.eq(userId) : null;
    }
    private static BooleanExpression createdBefore(Instant createTo){
        return ObjectUtils.isNotEmpty(createTo) ? notification.createdAt.before(createTo):null;
    }
    private static BooleanExpression createdAfter(Instant createFrom){
        return ObjectUtils.isNotEmpty(createFrom) ? notification.createdAt.after(createFrom):null;
    }
}
