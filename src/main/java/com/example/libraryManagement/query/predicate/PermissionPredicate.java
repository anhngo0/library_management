package com.example.libraryManagement.query.predicate;

import com.example.libraryManagement.model.entity.QPermission;
import com.example.libraryManagement.query.params.GetPermissionParam;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.dsl.BooleanExpression;
import org.apache.commons.lang3.StringUtils;

public class PermissionPredicate {
    private static QPermission permission = QPermission.permission;
    private static BooleanBuilder where = new BooleanBuilder();
    public static BooleanBuilder getPermissions(GetPermissionParam getPermissionParam){
        return where.and(commonAttributesContainKeyWord(getPermissionParam.getKeyword()));
    }
    private static BooleanExpression commonAttributesContainKeyWord(String keyword){
        return StringUtils.isNotBlank(keyword) ?
                         permission.name.containsIgnoreCase(keyword)
                        .or(permission.description.containsIgnoreCase(keyword))
                :null;
    }

}
