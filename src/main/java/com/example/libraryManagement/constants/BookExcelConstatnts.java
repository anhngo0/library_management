package com.example.libraryManagement.constants;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

public class BookExcelConstatnts {
    public static Map<String, String> importExcelHeader;

    static {
        importExcelHeader = new HashMap<>();
        importExcelHeader.put("Tiêu đề", "titleName");
        importExcelHeader.put("Tên khác", "alterName");
        importExcelHeader.put("Tác giả", "author");
        importExcelHeader.put("Vị trí xếp giá", "classNumber");
        importExcelHeader.put("Giá", "price");
        importExcelHeader.put("Mã ISBN", "ISBNNumber");
        importExcelHeader.put("Số lượng", "quantity");
        importExcelHeader.put("Năm xuất bản", "year_of_publication");
        importExcelHeader.put("Nhà xuất bản", "publisher");
        importExcelHeader.put("Thể loại", "category");
        importExcelHeader.put("Mã xếp giá","bookPosition");
        importExcelHeader.put("Ngôn ngữ", "language");
        importExcelHeader.put("Mô tả", "description");
    }

    public static Map<String, String> exportExcelHeader;

    static {
        exportExcelHeader = new LinkedHashMap<>();
        exportExcelHeader.put("Mã xếp giá", "classNumber");
        exportExcelHeader.put("Mã vị trí", "bookPosition");
        exportExcelHeader.put("Tên tiếng việt", "vietnameseName");
        exportExcelHeader.put("Tên khác", "alterName");
        exportExcelHeader.put("Tác giả", "author");
        exportExcelHeader.put("Mã ISBN", "ISBNNumber");
        exportExcelHeader.put("Số lượng", "quantity");
        exportExcelHeader.put("Năm xuất bản", "year_of_publication");
        exportExcelHeader.put("Nhà xuất bản", "publisher");
        exportExcelHeader.put("Thể loại", "category");
        exportExcelHeader.put("Ngôn ngữ", "language");
    }
}