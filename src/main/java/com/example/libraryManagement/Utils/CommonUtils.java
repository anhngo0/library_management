package com.example.libraryManagement.Utils;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Year;
import java.util.Date;

public class CommonUtils {
    public static boolean validateBetweenNotAnyNull(Object from, Object to) {
        if (from == null || to == null) {
            return true;
        }
        return false;
    }
    public static boolean validateYearBetween(Year from, Year to) {
        if (validateBetweenNotAnyNull(from, to))
            return false;
        return !from.isAfter(to);
    }
    public static  boolean validateDateBetween(LocalDateTime from, LocalDateTime to){
        if(validateBetweenNotAnyNull(from, to)){
            return false;
        }
        return !from.isAfter(to);
    }
    public static  boolean validateDateBetween(LocalDate from, LocalDate to){
        if(validateBetweenNotAnyNull(from, to)){
            return false;
        }
        return !from.isAfter(to);
    }
    public static boolean validateIntegerBetween(Integer from, Integer to) {
        if (validateBetweenNotAnyNull(from, to)) {
            return false;
        }
        return from < to;
    }
    public static String getFileName(MultipartFile file) {
        String originalFileName = file.getOriginalFilename();
        assert originalFileName != null;
        return originalFileName.substring(0, originalFileName.lastIndexOf('.'));
    }

    public static String getFileExtension(MultipartFile file) {
        String originalFileName = file.getOriginalFilename();
        assert originalFileName != null;
        return originalFileName.substring(originalFileName.lastIndexOf('.') + 1);
    }

    public static Workbook getWorkbook(String excelFileExtension) throws IOException {
        Workbook workbook = null;

        if (excelFileExtension.endsWith("xlsx")) {
            workbook = new XSSFWorkbook();
        } else if (excelFileExtension.endsWith("xls")) {
            workbook = new HSSFWorkbook();
        } else {
            throw new IllegalArgumentException("The specified file is not Excel file");
        }
        return workbook;
    }
}
