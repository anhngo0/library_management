package com.example.libraryManagement.query.predicate;
import com.example.libraryManagement.model.entity.QBookCategory;
import com.example.libraryManagement.query.params.GetBookCategoriesQueryParams;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Predicate;
import org.apache.commons.lang3.StringUtils;

public class BookCategoryPredicate {
    private static final QBookCategory bookCategory = QBookCategory.bookCategory;
    public static Predicate getBookCategoryPredicate(GetBookCategoriesQueryParams getBookCategoriesQueryParams){
        BooleanBuilder where = new BooleanBuilder();
        return where.and(commonAttributesContainKeyword(getBookCategoriesQueryParams.getKeyword()));
    }
    private static Predicate commonAttributesContainKeyword(String keyword){
        return StringUtils.isNotBlank(keyword) ? bookCategory.name.containsIgnoreCase(keyword):null;
    }
}
