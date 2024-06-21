package com.example.libraryManagement.mapper;

import com.example.libraryManagement.constants.DateTimeFormatConstant;
import com.example.libraryManagement.model.dto.fullInfo.ProfileFullInfoDto;
import com.example.libraryManagement.model.dto.ProfileMinInfoDto;
import com.example.libraryManagement.model.dto.form.UpsertProfileForm;
import com.example.libraryManagement.model.entity.Profile;
import org.mapstruct.*;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Mapper(
        componentModel = MappingConstants.ComponentModel.SPRING
)
public abstract class ProfileMapper {
    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE, nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    public abstract ProfileFullInfoDto toFullInfoDto(Profile profile);

    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE)
    public abstract ProfileMinInfoDto toMinInfoDto(Profile profile);

    @Mapping(source = "cccd_Id", target = "cccd_Id")
//    @Mapping(source = "doB", target = "doB", qualifiedByName = "dateFormat")
    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE, nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    public abstract Profile toEntity(UpsertProfileForm upsertProfileForm);

    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE, nullValuePropertyMappingStrategy = NullValuePropertyMappingStrategy.IGNORE)
    public abstract Profile toEntity_update(UpsertProfileForm upsertProfileForm, @MappingTarget Profile profile);

//    @Named("dateFormat")
//    protected LocalDateTime dateFormat(LocalDate date){
//        return LocalDate.parse(date.toString(),DateTimeFormatConstant.DATE_EXCEL_FORMATTER).atStartOfDay();
//    }
}
