package com.example.libraryManagement.query.predicate;

import com.example.libraryManagement.Utils.CommonUtils;
import com.example.libraryManagement.model.entity.QImportTicket;
import com.example.libraryManagement.query.params.GetImportTicketParams;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.dsl.BooleanExpression;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;

import java.time.LocalDateTime;
import java.util.Date;

public class ImportTicketPredicate {
    private static final QImportTicket importTicket = QImportTicket.importTicket;
    public static BooleanBuilder getImportTickets(GetImportTicketParams getImportTicketParams){
        BooleanBuilder where = new BooleanBuilder();
        return where
                .and(matchLibrarianProfileId(getImportTicketParams.getLibrarianId()))
                .and(matchManaggerProfileId(getImportTicketParams.getManagerId()))
                .and(totalPriceInBetween(getImportTicketParams.getTotalPrice_from(), getImportTicketParams.getTotalPrice_to()))
                .and(createDateInBetween(getImportTicketParams.getCreate_from(), getImportTicketParams.getCreate_to()))
                .and(totalQuantityInBetween(getImportTicketParams.getTotalQuantity_from(), getImportTicketParams.getTotalQuantity_to()))
                .and(commonAttributesContainKeyword(getImportTicketParams.getKeyword()));
    }

    private static BooleanExpression matchLibrarianProfileId(Long creatorId){
        return ObjectUtils.isNotEmpty(creatorId)  ?
                importTicket.creator.id.eq(creatorId):null;
    }

    private static BooleanExpression matchManaggerProfileId(Long approverId){
        return ObjectUtils.isNotEmpty(approverId)  ?
                (importTicket.approver.id.eq(approverId)):null;
    }
    private static BooleanExpression commonAttributesContainKeyword(String keyword){
        return StringUtils.isNotBlank(keyword) ?
                importTicket.import_way.containsIgnoreCase(keyword)
                        .and(importTicket.supplier.containsIgnoreCase(keyword))
                        .and(importTicket.creator.name.containsIgnoreCase(keyword))
                        .and(importTicket.approver.name.containsIgnoreCase(keyword)):null;
    }

    private static BooleanExpression createDateInBetween(LocalDateTime from, LocalDateTime to){
        return CommonUtils.validateDateBetween(from,to)? importTicket.created_date.between(from,to):null;
    }
    private static BooleanExpression totalQuantityInBetween(Integer from, Integer to){
        return (from == null || to == null) ? importTicket.totalQuantity.between(from,to):null;
    }
    private static BooleanExpression totalPriceInBetween(Double from, Double to){
        return (from == null || to == null) ? importTicket.totalPrice.between(from, to):null;
    }

}
