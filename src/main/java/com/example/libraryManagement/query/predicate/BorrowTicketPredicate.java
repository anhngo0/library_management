package com.example.libraryManagement.query.predicate;

import com.example.libraryManagement.Utils.CommonUtils;
import com.example.libraryManagement.model.entity.Book;
import com.example.libraryManagement.model.entity.QBorrowTicket;
import com.example.libraryManagement.model.entity.TicketStatus;
import com.example.libraryManagement.query.params.GetBorrowTicketParams;
import com.example.libraryManagement.query.params.GetImportTicketParams;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.dsl.BooleanExpression;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

public class BorrowTicketPredicate {
    private final static QBorrowTicket borrowedTicket = QBorrowTicket.borrowTicket;
    public static BooleanBuilder getBorrowedTickets(GetBorrowTicketParams getBorrowTicketParams){
        BooleanBuilder where = new BooleanBuilder();
        return where
                .and(matchListBorrowedTicketId(getBorrowTicketParams.getListIds()))
                .and(borrowedDateInBetween(getBorrowTicketParams.getBorrowed_from(),getBorrowTicketParams.getBorrowed_to()))
                .and(returnedDateInBetween(getBorrowTicketParams.getReturned_from(),getBorrowTicketParams.getReturned_to()))
                .and(commonAttributesContainKeyword(getBorrowTicketParams.getKeyword()))
                .and(statusIn(TicketStatus.PENDING,TicketStatus.ACCEPT));
    }


    public static BooleanBuilder getPendingBorrowedTickets(GetBorrowTicketParams getBorrowTicketParams){
        BooleanBuilder where = new BooleanBuilder();
        return where
                .and(matchListBorrowedTicketId(getBorrowTicketParams.getListIds()))
                .and(borrowedDateInBetween(getBorrowTicketParams.getBorrowed_from(),getBorrowTicketParams.getBorrowed_to()))
                .and(returnedDateInBetween(getBorrowTicketParams.getReturned_from(),getBorrowTicketParams.getReturned_to()))
                .and(commonAttributesContainKeyword(getBorrowTicketParams.getKeyword()))
                .and(statusIn(TicketStatus.PENDING));
    }

    public static BooleanBuilder getAcceptedBorrowedTickets(GetBorrowTicketParams getBorrowTicketParams){
        BooleanBuilder where = new BooleanBuilder();
        return where
                .and(matchLibrarianProfileId(getBorrowTicketParams.getLibrarianId()))
                .and(matchMemberProfileId(getBorrowTicketParams.getMemberId()))
                .and(matchListBorrowedTicketId(getBorrowTicketParams.getListIds()))
                .and(borrowedDateInBetween(getBorrowTicketParams.getBorrowed_from(),getBorrowTicketParams.getBorrowed_to()))
                .and(returnedDateInBetween(getBorrowTicketParams.getReturned_from(),getBorrowTicketParams.getReturned_to()))
                .and(commonAttributesContainKeyword(getBorrowTicketParams.getKeyword()))
                .and(statusIn(TicketStatus.ACCEPT));
    }

    private static BooleanExpression matchLibrarianProfileId(Long creatorId){
        return ObjectUtils.isNotEmpty(creatorId)  ?
                borrowedTicket.librarian.id.eq(creatorId):null;
    }

    private static BooleanExpression matchMemberProfileId(Long memberId){
        return ObjectUtils.isNotEmpty(memberId)  ?
                (borrowedTicket.member.id.eq(memberId)):null;
    }

    public static BooleanExpression matchListBorrowedTicketId(List<Long> listIds){
        return !listIds.isEmpty() && listIds != null ? borrowedTicket.id.in(listIds):null;
    }

    private static BooleanExpression statusIn(TicketStatus... status){
        return ObjectUtils.isNotEmpty(status) ? borrowedTicket.status.in(status):null;
    }

    private static BooleanExpression borrowedDateInBetween(LocalDateTime from, LocalDateTime to){
        return CommonUtils.validateDateBetween(from, to) ? borrowedTicket.borrowed_date.between(from,to):null;
    }

    private static BooleanExpression returnedDateInBetween(LocalDateTime from, LocalDateTime to){
        return CommonUtils.validateDateBetween(from, to) ? borrowedTicket.returned_date.between(from, to):null;
    }

    private static BooleanExpression commonAttributesContainKeyword(String keyword){
        return StringUtils.isNotBlank(keyword) ?
                borrowedTicket.librarian.name.containsIgnoreCase(keyword)
                        .and(borrowedTicket.member.name.containsIgnoreCase(keyword))
                :null;
    }
}
