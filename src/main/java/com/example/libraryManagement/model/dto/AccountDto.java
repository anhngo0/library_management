package com.example.libraryManagement.model.dto;

import com.example.libraryManagement.model.entity.Profile;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import lombok.Data;

import java.io.Serializable;

@Data
public class AccountDto implements Serializable {
    private Long id;
    private String username;
    private ProfileMinInfoDto profile;
    private String roleName;
}
