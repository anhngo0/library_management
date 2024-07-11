package com.example.libraryManagement.query.predicate;

import com.example.libraryManagement.Utils.CommonUtils;
import com.example.libraryManagement.model.entity.BookStatus;
import com.example.libraryManagement.model.entity.QBook;
import com.example.libraryManagement.query.params.GetBookParams;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.dsl.BooleanExpression;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;

import java.time.Year;

import static org.apache.commons.lang3.BooleanUtils.and;

public class BookPredicate {
    private static final QBook book = QBook.book;
    public static BooleanBuilder getBooks(GetBookParams getBookParams){

        BooleanBuilder where = new BooleanBuilder();
        return where
                .and(isBookBorrowed(getBookParams.isBorrowed()))
                .and(matchLiquidationId(getBookParams.getLiquidationTicketId()))
                .and(matchCategoryId(getBookParams.getCategoryId()))
                .and(matchClassNumberId(getBookParams.getClassNumberId()))
                .and(quantityInBetween(getBookParams.getQuantityFrom(),getBookParams.getQuantityTo()))
                .and(yearOfPublicationInBetween(getBookParams.getYearOfPublicationFrom(),getBookParams.getYearOfPublicationTo()))
                .and(commonAttributeContainKeyword(getBookParams.getKeyword()))
                ;
    }

    public static BooleanBuilder getBooksInUseNew() {
        BooleanBuilder where = new BooleanBuilder();
        return where.and(matchStatus(BookStatus.IN_USE_NEW));
    }

    private static BooleanExpression isBookBorrowed(Boolean isBorrowed){
        return ObjectUtils.isNotEmpty(isBorrowed) ? book.isBorrowed.eq(isBorrowed) :null;
    }

    private static BooleanExpression matchLiquidationId(Long id){
        return ObjectUtils.isNotEmpty(id) ? (book.liquidationTicket.id.eq(id).and(statusIn(BookStatus.LIQUIDATED,BookStatus.INACTIVE))):null;
    }

    private static BooleanExpression matchCategoryId(Long id){
        return ObjectUtils.isNotEmpty(id)  ? book.category.id.eq(id) : null;
    }

    private static BooleanExpression matchStatus(BookStatus status){
        return ObjectUtils.isNotEmpty(status) ? book.status.eq(status):null;
    }
    private static BooleanExpression matchClassNumberId(Long id){
        return ObjectUtils.isNotEmpty(id) ? book.classNumber.id.eq(id):null;
    }

    private static BooleanExpression statusIn(BookStatus... statuses) {
        return ObjectUtils.isNotEmpty(statuses)? book.status.in(statuses) : null;
    }

    private static BooleanExpression yearOfPublicationInBetween(Year from, Year to) {
        return CommonUtils.validateYearBetween(from, to) ? book.year_of_publication.between(from, to):null;
    }
    private static BooleanExpression quantityInBetween(Integer from, Integer to){
        return CommonUtils.validateIntegerBetween(from, to) ? book.quantity.between(from,to):null;
    }

    private static BooleanExpression commonAttributeContainKeyword(String keyword){
        return StringUtils.isNotBlank(keyword) ?
                book.titleName.containsIgnoreCase(keyword)
                        .or(book.alterName.containsIgnoreCase(keyword))
                        .or(book.author.containsIgnoreCase(keyword))
                        .or(book.publisher.containsIgnoreCase(keyword))
                        .or(book.language.containsIgnoreCase(keyword))
                        .or(book.description.containsIgnoreCase(keyword))
                : null;
    }


}
