package com.example.libraryManagement.service.serviceImpl;

import com.example.libraryManagement.Utils.CommonUtils;
import com.example.libraryManagement.exeption.ResourceNotFoundException;
import com.example.libraryManagement.mapper.FileStorageMapper;
import com.example.libraryManagement.model.dto.FileStorageDto;
import com.example.libraryManagement.model.entity.FileDescription;
import com.example.libraryManagement.model.entity.FileStorage;
import com.example.libraryManagement.model.repository.FileStorageRepository;
import com.example.libraryManagement.query.params.GetFileStoragesQueryParam;
import com.example.libraryManagement.query.predicate.FileStoragePredicate;
import com.example.libraryManagement.service.IFileStorageService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
@RequiredArgsConstructor
public class FileStorageService implements IFileStorageService {

    private final FileStorageMapper fileStorageMapper;

    private final FileStorageRepository fileStorageRepository;

    @Override
    public FileStorage getImgById(Long id) {
        FileStorage file = fileStorageRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("resource not found"));
        if (!file.getDescription().equals(FileDescription.IMAGE)) {
            throw new ResourceNotFoundException("imageNotFound");
        }
        return file;

    }

    @Override
    public FileStorage getDocumentById(Long id){
        FileStorage file = fileStorageRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("resource not found"));
        if(!file.getDescription().equals(FileDescription.DOCUMENT)){
            throw new ResourceNotFoundException("document not found");
        }
        return file;
    }

    @Override
    public void uploadMultipleFiles(Long associatedEntityId, String associatedEntityType
            , FileDescription fileDescription, MultipartFile... files){
        if(files == null || files.length == 0){
             return;
        }
        List<MultipartFile>multipartFiles = Arrays.asList(files);
        List<FileStorage> uploadedFiles =new ArrayList<>();
        multipartFiles.forEach(file -> {
            if(file == null || file.isEmpty()){
                return;
            }
            try {
                FileStorage uploadFile = FileStorage.builder()
                        .name(CommonUtils.getFileName(file))
                        .contentType(file.getContentType())
                        .description(fileDescription)
                        .extension(CommonUtils.getFileExtension(file))
                        .associatedEntityType(associatedEntityType)
                        .associatedEntityId(associatedEntityId)
                        .data(file.getBytes())
                        .build();
                fileStorageRepository.save(uploadFile);
                uploadedFiles.add(uploadFile);
            } catch (IOException e){
                e.printStackTrace();
                throw new RuntimeException(e);
            }
        });
    }


    @Override
    public List<FileStorageDto> getAllFilesOfAnEntity(String associatedEntityType, Long associatedEntityId, FileDescription fileDescription) {
        List<FileStorage> fileStorages = (List<FileStorage>) fileStorageRepository.findAll(FileStoragePredicate.getFileStoragePredicate(
                new GetFileStoragesQueryParam(
                        associatedEntityId,
                        associatedEntityType,
                        fileDescription
                )));
        return fileStorages.parallelStream().map(fileStorageMapper::toDto).toList();
    }

    @Override
    public List<FileStorageDto> getAllFilesOfAnEntityWithoutData(String associatedEntityType, Long associatedEntityId, FileDescription fileDescription) {
          List<FileStorageDto> fileStorageDtos = new ArrayList<FileStorageDto>();
        fileStorageRepository.findAll(FileStoragePredicate.getFileStoragePredicate(new GetFileStoragesQueryParam(
                associatedEntityId,
                associatedEntityType,
                fileDescription
        ))).forEach(fileStorage -> fileStorageDtos.add(fileStorageMapper.toDto(fileStorage)));
        return fileStorageDtos;
    }

    @Override
    public void deleteAllFilesOfAnEntity(String associatedEntityType, Long associatedEntityId, FileDescription fileDescription) {
        List<FileStorage> fileStorages = (List<FileStorage>) fileStorageRepository.findAll(FileStoragePredicate.getFileStoragePredicate(new GetFileStoragesQueryParam(
                associatedEntityId,
                associatedEntityType,
                fileDescription
        )));
        fileStorageRepository.deleteAll(fileStorages);
    }
}
