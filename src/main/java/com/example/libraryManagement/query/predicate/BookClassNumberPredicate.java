package com.example.libraryManagement.query.predicate;

import com.example.libraryManagement.model.entity.QBookClassNumber;
import com.example.libraryManagement.query.params.GetBookCategoriesQueryParams;
import com.example.libraryManagement.query.params.GetBookClassNumberQueryParams;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Predicate;
import org.apache.commons.lang3.StringUtils;

public class BookClassNumberPredicate {
    static QBookClassNumber bookClassNumber = QBookClassNumber.bookClassNumber;
    public static Predicate getBookClassNumberPredicate(
            GetBookClassNumberQueryParams getBookClassNumberQueryParams
    ){
        BooleanBuilder where = new BooleanBuilder();
        return where.and(commonAttributesContainKeyword(getBookClassNumberQueryParams.getKeyword()));
    }
    private static Predicate commonAttributesContainKeyword(String keyword){
        return StringUtils.isNotBlank(keyword) ? bookClassNumber.name.containsIgnoreCase(keyword):null;
    }
}
