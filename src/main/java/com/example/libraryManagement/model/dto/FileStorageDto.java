package com.example.libraryManagement.model.dto;

import com.example.libraryManagement.model.entity.FileDescription;
import lombok.Data;

import java.io.Serializable;

@Data
public class FileStorageDto {
    private Long id;
    private String name;
    private String contentType;
    private String extension;
    private Long associatedEntityId;
    private String associatedEntityType;
    private FileDescription description;
}
