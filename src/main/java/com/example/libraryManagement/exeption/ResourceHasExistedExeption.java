package com.example.libraryManagement.exeption;

public class ResourceHasExistedExeption extends RuntimeException{
    public ResourceHasExistedExeption(String message) {
        super(message);
    }
}
