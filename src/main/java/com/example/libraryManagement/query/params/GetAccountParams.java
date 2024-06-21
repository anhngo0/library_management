package com.example.libraryManagement.query.params;

import lombok.Data;

@Data
public class GetAccountParams {
    private String keyword;
    private Long accountId;
}
