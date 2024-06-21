package com.example.libraryManagement.mapper;

import com.example.libraryManagement.model.dto.AccountDto;
import com.example.libraryManagement.model.dto.form.UpsertAccountForm;
import com.example.libraryManagement.model.dto.form.UpsertRoleForm;
import com.example.libraryManagement.model.dto.fullInfo.AccountFullInfoDto;
import com.example.libraryManagement.model.entity.Account;
import org.mapstruct.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;

@Mapper(
        componentModel = MappingConstants.ComponentModel.SPRING,
        uses = { IdToEntityMapper.class})
public abstract class AccountMapper {
    @Autowired
    protected PasswordEncoder bCryptPasswordEncoder;

    @Mapping(source = "role.name", target="roleName")
    @BeanMapping(unmappedTargetPolicy = ReportingPolicy.IGNORE)
    public abstract AccountDto toDto(Account account);

    public abstract AccountFullInfoDto toFullInfoDto(Account account);

    @Mapping(target = "id", ignore = true)
    @Mapping(source = "profileId", target = "profile")
    @Mapping(source = "roleId", target = "role")
    @Mapping(target = "password", source = "password", qualifiedByName = "encodePassword")
    public abstract Account toEntity(UpsertAccountForm upsertAccountForm);

    @Named("encodePassword")
    public String encodePassword(String password) {
        return bCryptPasswordEncoder.encode(password);
    }
}
