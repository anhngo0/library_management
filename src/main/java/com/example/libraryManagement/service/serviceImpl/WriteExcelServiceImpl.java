package com.example.libraryManagement.service.serviceImpl;

import com.example.libraryManagement.service.IWriteEcxelService;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import static com.example.libraryManagement.constants.BookExcelConstatnts.exportExcelHeader;
import static com.example.libraryManagement.constants.DateTimeFormatConstant.DATE_TIME_FORMAT;
@Service
public class WriteExcelServiceImpl<T> implements IWriteEcxelService<T> {
    @Override
    public void writeExcelFile(List<T> list, OutputStream excelOutputStream, Class<T> tClass) {

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet();

        int rowIndex = 1;
        // Write Header
        writeHeader(sheet, rowIndex);

        // Write Data
        try {
            writeData(sheet, rowIndex + 1, list, tClass);
        } catch (InvocationTargetException | IllegalAccessException | NoSuchMethodException exception) {
            throw new RuntimeException(exception);
        }

        // Auto resize
        autoResizeColumn(sheet, sheet.getRow(rowIndex).getLastCellNum());

        // Create Excel file
        createFile(workbook, excelOutputStream);
    }

    public void writeHeader(Sheet sheet, int rowIndex) {
        Row headerRow = sheet.createRow(rowIndex);
        String[] headers = exportExcelHeader.keySet().toArray(new String[0]);
        CellStyle cellStyle = cellStyleForHeader(sheet);

        for (int columnIndex = 0; columnIndex < headers.length; columnIndex++) {
            Cell cell = headerRow.createCell(columnIndex);
            cell.setCellValue(headers[columnIndex]);
            cell.setCellStyle(cellStyle);
        }
    }

    public void writeData(Sheet sheet, int rowIndex, List<T> list, Class<T> tClass) throws InvocationTargetException, IllegalAccessException, NoSuchMethodException {

        CellStyle cellStyle = cellStyleForData(sheet);
        List<String> fieldName = exportExcelHeader.values().stream().toList();
        List<Method> methodList = new ArrayList<>();
        for (String f: fieldName) {
            String methodName = "get" + f.substring(0,1).toUpperCase() + f.substring(1);
            Method method = tClass.getDeclaredMethod(methodName);
            methodList.add(method);
        }

        for (T l : list) {
            Row row = sheet.createRow(rowIndex);
            for (Method m : methodList) {
                Cell cell = row.createCell(methodList.indexOf(m));
                Class<?> c = m.getReturnType();

                if (m.invoke(l) == null) {
                    cell.setCellValue("");
                    cell.setCellStyle(cellStyle);
                    continue;
                }

                switch (c.getSimpleName()) {
                    case "String" -> cell.setCellValue((String) m.invoke(l));
                    case "Double" -> cell.setCellValue((Double) m.invoke(l));
                    case "Long" -> cell.setCellValue((Long) m.invoke(l));
                    case "Integer" -> cell.setCellValue((Integer) m.invoke(l));
                    case "LocalDateTime" -> {
                        LocalDateTime localDateTime = (LocalDateTime) m.invoke(l);
                        cell.setCellValue(localDateTime.format(DATE_TIME_FORMAT));
                    }
                    case "Year" -> {
                        int year = Integer.parseInt(m.invoke(l).toString());
                        cell.setCellValue(year);
                    }
                }
                cell.setCellStyle(cellStyle);
            }
            rowIndex++;

        }

    }

    public void autoResizeColumn(Sheet sheet, int lastColumn) {
        for (int columnIndex = 0; columnIndex <= lastColumn; columnIndex++) {
            sheet.autoSizeColumn(columnIndex);
        }
    }

    public void createFile(Workbook workbook, OutputStream excelOutputStream) {
        try {
            workbook.write(excelOutputStream);
            workbook.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public CellStyle cellStyleForHeader(Sheet sheet) {
        Font font = sheet.getWorkbook().createFont();
        font.setBold(true);
        font.setFontName("Times New Roman");
        font.setFontHeightInPoints((short) 12);

        CellStyle cellStyle = sheet.getWorkbook().createCellStyle();
        cellStyle.setFont(font);

        return cellStyle;
    }

    // create a cell style for data row
    public CellStyle cellStyleForData(Sheet sheet) {
        Font font = sheet.getWorkbook().createFont();
        font.setFontName("Times New Roman");
        font.setFontHeightInPoints((short) 11);

        CellStyle cellStyle = sheet.getWorkbook().createCellStyle();
        cellStyle.setFont(font);
        return cellStyle;
    }
}
