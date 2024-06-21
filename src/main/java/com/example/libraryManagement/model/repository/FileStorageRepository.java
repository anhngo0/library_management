package com.example.libraryManagement.model.repository;

import com.example.libraryManagement.model.entity.FileStorage;
import org.springframework.stereotype.Repository;

@Repository
public interface FileStorageRepository extends ParentRepository<FileStorage, Long>{
}
