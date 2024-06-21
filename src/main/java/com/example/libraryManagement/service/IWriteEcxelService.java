package com.example.libraryManagement.service;

import org.springframework.security.access.prepost.PreAuthorize;

import java.io.OutputStream;
import java.util.List;

public interface IWriteEcxelService<T> {
    @PreAuthorize("hasAnyRole('ROLE_MANAGER', 'ROLE_LIBRARIAN)")
    void writeExcelFile(List<T> list, OutputStream excelOutputStream, Class<T> tClass);
}
