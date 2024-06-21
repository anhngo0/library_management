package com.example.libraryManagement.service;

import com.example.libraryManagement.model.dto.form.UpsertBookForm;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

public interface IReadExcelService<T> {

    List<T> readExcelFile(InputStream inputStream, String excelPath, Class<T> tClass) throws IOException, InvocationTargetException, IllegalAccessException, InstantiationException, NoSuchMethodException;
}
