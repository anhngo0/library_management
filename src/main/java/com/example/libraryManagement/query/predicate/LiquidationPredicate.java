package com.example.libraryManagement.query.predicate;

import com.example.libraryManagement.Utils.CommonUtils;
import com.example.libraryManagement.model.entity.QLiquidationTicket;
import com.example.libraryManagement.model.entity.TicketStatus;
import com.example.libraryManagement.model.repository.BookRepository;
import com.example.libraryManagement.query.params.GetLiquidationTicketParams;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.dsl.BooleanExpression;
import lombok.RequiredArgsConstructor;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;
@RequiredArgsConstructor
public class LiquidationPredicate {
    private static  BookRepository bookRepository;
    private static final QLiquidationTicket liquidationTicket = QLiquidationTicket.liquidationTicket;

    public static BooleanBuilder getLiquidationTickets(GetLiquidationTicketParams getLiquidationTicketParams){
        BooleanBuilder where = new BooleanBuilder();
        return where
                .and(matchLibrarianProfileId(getLiquidationTicketParams.getCreatorId()))
                .and(matchManaggerProfileId(getLiquidationTicketParams.getApproverId()))
                .and(exportPriceInBetween(getLiquidationTicketParams.getExportPrice_from(),getLiquidationTicketParams.getExportPrice_to()))
                .and(createDateInBetween(getLiquidationTicketParams.getCreate_from(), getLiquidationTicketParams.getCreate_to()))
                .and(numberInBetween(getLiquidationTicketParams.getTotalQuantity_from(), getLiquidationTicketParams.getTotalQuantity_to()))
                .and(commonAttributesContainKeyword(getLiquidationTicketParams.getKeyword()));

    }

    private static BooleanExpression matchLibrarianProfileId(Long creatorId){
        return ObjectUtils.isNotEmpty(creatorId)  ?
                liquidationTicket.creator.id.eq(creatorId):null;
    }

    private static BooleanExpression matchManaggerProfileId(Long approverId){
        return ObjectUtils.isNotEmpty(approverId)  ?
                (liquidationTicket.approver.id.eq(approverId)):null;
    }

    private static BooleanExpression commonAttributesContainKeyword(String keyword){
        return StringUtils.isNotBlank(keyword) ?
                liquidationTicket.creator.name.containsIgnoreCase(keyword)
                        .and(liquidationTicket.approver.name.containsIgnoreCase(keyword)):null;
    }

    private static BooleanExpression createDateInBetween(LocalDateTime from, LocalDateTime to){
        return CommonUtils.validateDateBetween(from,to)? liquidationTicket.created_date.between(from,to):null;
    }
    private static BooleanExpression numberInBetween(Integer from, Integer to){
        return (from == null || to == null) ? liquidationTicket.totalQuantity.between(from,to):null;
    }
    private static BooleanExpression exportPriceInBetween(Double from, Double to){
        return (from == null || to == null) ? liquidationTicket.export_price.between(from, to):null;
    }

}
