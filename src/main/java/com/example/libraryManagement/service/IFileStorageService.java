package com.example.libraryManagement.service;

import com.example.libraryManagement.model.dto.FileStorageDto;
import com.example.libraryManagement.model.entity.FileDescription;
import com.example.libraryManagement.model.entity.FileStorage;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface IFileStorageService {

    FileStorage getImgById(Long id);

    FileStorage getDocumentById(Long id);

    void uploadMultipleFiles(Long associatedEntityId, String associatedEntityType
            , FileDescription fileDescription, MultipartFile... files);

    List<FileStorageDto> getAllFilesOfAnEntity(String associatedEntityType, Long associatedEntityId, FileDescription fileDescription);

    List<FileStorageDto> getAllFilesOfAnEntityWithoutData(String associatedEntityType, Long associatedEntityId, FileDescription fileDescription);
    void deleteAllFilesOfAnEntity(String associatedEntityType, Long associatedEntityId, FileDescription fileDescription);
}
