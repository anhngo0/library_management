package com.example.libraryManagement.query.predicate;

import com.example.libraryManagement.Utils.CommonUtils;
import com.example.libraryManagement.model.entity.QProfile;
import com.example.libraryManagement.model.entity.UserRole;
import com.example.libraryManagement.query.params.GetProfileParams;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.dsl.BooleanExpression;
import lombok.NoArgsConstructor;
import org.apache.commons.lang3.StringUtils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

public class ProfilePredicate {
    private static QProfile profile = QProfile.profile;
    public static BooleanBuilder getMemberProfiles(GetProfileParams getProfileParams){
        BooleanBuilder where = new BooleanBuilder();
        return where
                .and(matchUserRole(UserRole.MEMBER))
                .and(doBInBetween(getProfileParams.getFrom(),getProfileParams.getTo()))
                .and(commonAttributeContainKeyword(getProfileParams.getKeyword()));
    };

    public static BooleanBuilder getLibrarianProfiles(GetProfileParams getProfileParams){
        BooleanBuilder where = new BooleanBuilder();
        return where
                .and(matchUserRole(UserRole.LIBRARIAN))
                .and(doBInBetween(getProfileParams.getFrom(),getProfileParams.getTo()))
                .and(commonAttributeContainKeyword(getProfileParams.getKeyword()));
    };

    private static BooleanExpression matchUserRole(UserRole userRole){
        return profile.userRole.in(userRole);
    }

    private static BooleanExpression commonAttributeContainKeyword(String keyword){
        return StringUtils.isNotBlank(keyword) ?
                profile.name.containsIgnoreCase(keyword)
                        .and(profile.cccd_Id.containsIgnoreCase(keyword))
                        .and(profile.address.containsIgnoreCase(keyword))
                        .and(profile.email.containsIgnoreCase(keyword))
                        .and(profile.phone.containsIgnoreCase(keyword)) : null;

    }
    private static BooleanExpression doBInBetween(LocalDate from, LocalDate to){
        return CommonUtils.validateDateBetween(from,to) ?
                profile.DoB.between(from,to):null;
    }
}
