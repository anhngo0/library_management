package com.example.libraryManagement.mapper;

import com.example.libraryManagement.exeption.ResourceNotFoundException;
import com.example.libraryManagement.model.entity.*;
import com.example.libraryManagement.model.repository.*;
import org.aspectj.lang.annotation.AdviceName;
import org.mapstruct.Mapper;
import org.mapstruct.MappingConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.ObjectUtils;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Mapper(componentModel = MappingConstants.ComponentModel.SPRING)
public abstract class IdToEntityMapper {
    @Autowired
    protected BookCategoryRepository bookCategoryRepository;

    @Autowired
    protected  BookClassNumberRepository bookClassNumberRepository;

    @Autowired
    protected RoleRepository roleRepository;

    @Autowired
    protected ProfileRepository profileRepository;

    @Autowired
    protected BookRepository bookRepository;

    public BookCategory toCategory(Long categoryId){
        return !ObjectUtils.isEmpty(categoryId) ?
                bookCategoryRepository.findById(categoryId).orElseThrow(() -> new ResourceNotFoundException("resource not found"))
                : null;
    }

    public BookClassNumber toClassNumber(Long bookClassNumberId){
        return !ObjectUtils.isEmpty(bookClassNumberId) ?
                bookClassNumberRepository.findById(bookClassNumberId).orElseThrow(() -> new ResourceNotFoundException("resource not found"))
                :null;
    }

    public Role toRole(Long roleId) {
        return !ObjectUtils.isEmpty(roleId) ?
                roleRepository.findById(roleId).orElseThrow(() -> new ResourceNotFoundException("resourceNotFound")) : null;
    }

    public Profile toProfile(Long profileId){
        return !ObjectUtils.isEmpty(profileId) ?
                profileRepository.findById(profileId).orElseThrow(()-> new ResourceNotFoundException("resource not found"))
                :null;
    }

    public Set<Book> toBooks(Set<Long> bookIds){
        if (bookIds != null && !bookIds.isEmpty()) {
            return new HashSet<Book>(bookRepository.findAllById(bookIds));
        }
        throw new ResourceNotFoundException("resource not found");
    }
}
