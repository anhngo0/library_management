package com.example.libraryManagement.query.predicate;

import com.example.libraryManagement.model.entity.FileDescription;
import com.example.libraryManagement.model.entity.QFileStorage;
import com.example.libraryManagement.query.params.GetFileStoragesQueryParam;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.types.Predicate;
import com.querydsl.core.types.dsl.BooleanExpression;
import org.apache.commons.lang3.ObjectUtils;
import org.apache.commons.lang3.StringUtils;

public class FileStoragePredicate {
    private static QFileStorage fileStorage = QFileStorage.fileStorage;
    public static BooleanBuilder getFileStoragePredicate(GetFileStoragesQueryParam getFileStoragesQueryParam){
        BooleanBuilder where = new BooleanBuilder();
        return where
                .and(matchAssociatedEntityId(getFileStoragesQueryParam.getAssociatedEntityId()))
                .and(matchAssociatedEntityType(getFileStoragesQueryParam.getAssociatedEntityType()))
                .and(matchFileDescription(getFileStoragesQueryParam.getFileDescription()));
    }
    private static BooleanExpression matchAssociatedEntityId(Long id){
        return id != null ?fileStorage.associatedEntityId.eq(id) :null;
    }

    private static BooleanExpression matchAssociatedEntityType(String type){
        return StringUtils.isNotBlank(type) ?fileStorage.associatedEntityType.eq(type) :null;
    }

    private static BooleanExpression matchFileDescription(FileDescription description){
        return ObjectUtils.isNotEmpty(description) ?fileStorage.description.eq(description) :null;
    }
}
