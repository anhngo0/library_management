package com.example.libraryManagement.model.dto.fullInfo;

import com.example.libraryManagement.model.dto.RoleDto;
import com.example.libraryManagement.model.entity.Role;
import lombok.Data;

import java.io.Serializable;

@Data
public class AccountFullInfoDto  {
    private Long id;
    private String username;
    private String password;
    private ProfileFullInfoDto profile;
    private RoleDto role;
    private Boolean isEnabled;
}
