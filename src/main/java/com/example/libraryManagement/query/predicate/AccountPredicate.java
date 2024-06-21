package com.example.libraryManagement.query.predicate;

import com.example.libraryManagement.model.entity.QAccount;
import com.example.libraryManagement.model.entity.UserRole;
import com.example.libraryManagement.query.params.GetAccountParams;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.dsl.BooleanExpression;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;
import org.mapstruct.Mapper;

public class AccountPredicate {
    private static QAccount account = QAccount.account;

    public static BooleanBuilder getAccounts(GetAccountParams getAccountParams) {
        BooleanBuilder where = new BooleanBuilder();
        return where
                .and(matchedProfileId(getAccountParams.getAccountId()))
                .and(commonAttributesContainKeyword(getAccountParams.getKeyword()))
                .and(profileAttributesContainKeyword(getAccountParams.getKeyword()));
    }

    public static BooleanBuilder findByProfileRole(UserRole userRole) {
        BooleanBuilder where = new BooleanBuilder();
        return where.and(account.profile.userRole.eq(userRole));
    }

    public static BooleanBuilder findByProfileEmail(String email) {
        BooleanBuilder where = new BooleanBuilder();
        return where.and(account.profile.email.eq(email));
    }

    private static BooleanExpression commonAttributesContainKeyword(String keyword) {
        return StringUtils.isNotBlank(keyword) ?
                account.username.containsIgnoreCase(keyword)
                        .or(account.password.containsIgnoreCase(keyword))
                : null;
    }

//    find by email, name or phone in profile
    private static BooleanExpression profileAttributesContainKeyword(String keyword){
        return StringUtils.isNotBlank(keyword) ?
                account.profile.name.containsIgnoreCase(keyword)
                        .or(account.profile.email.containsIgnoreCase(keyword))
                        .or(account.profile.cccd_Id.containsIgnoreCase(keyword))
                :null;
    }
    private static BooleanExpression matchedProfileId(Long id){
        return ObjectUtils.isNotEmpty(id) ? account.profile.id.eq(id):null;
    }
}
