package com.example.libraryManagement.model.dto.fullInfo;

import com.example.libraryManagement.model.entity.UserRole;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Data
public class ProfileFullInfoDto{
    private Long id;
    private String name;
    private Date DoB;
    private String cccd_Id;
    private String address;
    private String phone;
    private String email;
    private UserRole userRole;
}
