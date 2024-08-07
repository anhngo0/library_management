package com.example.libraryManagement.model.dto;

import com.example.libraryManagement.model.dto.fullInfo.ProfileFullInfoDto;
import com.example.libraryManagement.model.entity.Profile;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import lombok.Data;

import java.io.Serializable;

@Data
public class AccountDto  {
    private Long id;
    private String username;
    private String roleName;
    private ProfileFullInfoDto profile;
}
