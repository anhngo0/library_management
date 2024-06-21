package com.example.libraryManagement.service.serviceImpl;

import com.example.libraryManagement.service.IReadExcelService;
import jakarta.validation.constraints.NotNull;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.slf4j.event.Level;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.math.BigInteger;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.Year;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Objects;

import static com.example.libraryManagement.constants.BookExcelConstatnts.importExcelHeader;
import static com.example.libraryManagement.constants.DateTimeFormatConstant.DATE_EXCEL_FORMATTER;

@Service
public class ReadExcelServiceImpl<T> implements IReadExcelService<T> {
    private static final int ROW_INDEX_START = 4;
    private final Logger logger = LoggerFactory.getLogger(ReadExcelServiceImpl.class);

    @Override

    public List<T> readExcelFile(InputStream inputStream,String excelPath, Class<T> tClass) throws IOException, InvocationTargetException, IllegalAccessException, InstantiationException, NoSuchMethodException {
        List<T> list = new ArrayList<T>();

        Workbook workbook = getWorkbook(inputStream, excelPath);
        Sheet sheet = workbook.getSheetAt(0);
        Row headerRow = sheet.getRow(ROW_INDEX_START - 2);
        logger.atInfo().log(headerRow.getFirstCellNum() + " : " + headerRow.getLastCellNum());

        for (Row row : sheet) {
            if (row.getRowNum() < ROW_INDEX_START - 1) {
                continue;
            }

            Iterator<Cell> cellIterator = row.cellIterator();

            T instance = tClass.getDeclaredConstructor().newInstance();

            while (cellIterator.hasNext()) {
                Cell nextCell = cellIterator.next();
                int columnIndex = nextCell.getColumnIndex();
                logger.atInfo().log("column: " + (columnIndex));
                ;

                String headerValue = getCellValue(headerRow.getCell(columnIndex));
                logger.atInfo().log("headerValue: "+ headerValue + " -> " + importExcelHeader.get(headerValue));
                Method method = getSetterMethod(tClass, importExcelHeader.get(headerValue));
                logger.atInfo().log(method.getName());

                String cellValue = getCellValue(nextCell);
                Class<?> arg = method.getParameterTypes()[0];
                logger.atInfo().log(arg.getTypeName());

                switch (arg.getSimpleName()) {
                    case "LocalDateTime" -> {
                        LocalDateTime localDateTime = null;
                        if (cellValue != null && !cellValue.equals("-")) {
                            localDateTime = LocalDate.parse(cellValue,
                                    DATE_EXCEL_FORMATTER).atStartOfDay();
                        }
                        method.invoke(instance, localDateTime);
                    }
                    case "Year" -> {
                        if(cellValue != null && !cellValue.equals("-")){
                            method.invoke(instance, Year.parse(cellValue));
                        }
                    }
                    case "Integer", "int" -> {
                        if(cellValue != null && !cellValue.equals("-")){
                            Integer integer = Integer.valueOf(cellValue);
                            method.invoke(instance, integer);
                        }
                    }
                    case "Double","double" -> {
                        if(cellValue != null && !cellValue.equals("-")){
                            Double doubleValue = Double.valueOf(cellValue);
                            method.invoke(instance, doubleValue);
                        }
                        logger.atInfo().log("price" + cellValue);
                    }

                    default -> {
                        if(cellValue != null && !cellValue.equals("-")){
                            method.invoke(instance, cellValue);
                        }
                        logger.atInfo().log(cellValue);
                    }
                }

            }
            list.add(instance);
        }
        inputStream.close();
        workbook.close();
        return list;
    }

    // get cell value with string format
    public String getCellValue(Cell cell) {
        CellType cellStyle = cell.getCellType();
        DataFormatter dataFormatter = new DataFormatter();
        String cellValue = dataFormatter.formatCellValue(cell);
        switch (cellStyle) {
            case STRING, NUMERIC -> {
                return cellValue;
            }
            default -> {
                return null;
            }
        }
    }

    public Workbook getWorkbook(@NotNull InputStream inputStream, String excelFile) throws IOException {
        Workbook workbook = null;
        if (excelFile.endsWith("xlsx")) {
            workbook = new XSSFWorkbook( inputStream);
        } else if (excelFile.endsWith("xls")) {
            workbook = new HSSFWorkbook(inputStream);
        } else {
            throw new IllegalArgumentException("The specified file is not Excel file");
        }
        return workbook;
    }

    // return setter method  of @param tClass that has name is @param fieldName
    private Method getSetterMethod(Class<T> tClass, String fieldName) {
        Class<?> type = null;
        try {
            assert tClass != null;
            logger.atInfo().log(tClass.getSimpleName() + " : " + fieldName);
            type = tClass.getDeclaredField(fieldName).getType();
            String methodName = "set" + fieldName.substring(0,1).toUpperCase() + fieldName.substring(1);
            return tClass.getDeclaredMethod(methodName, type);
        } catch (NoSuchFieldException | NoSuchMethodException | NullPointerException e) {

            throw new RuntimeException(e);
        }
    }
}
