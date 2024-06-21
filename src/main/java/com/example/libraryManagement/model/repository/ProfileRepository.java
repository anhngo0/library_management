package com.example.libraryManagement.model.repository;

import com.example.libraryManagement.model.entity.Profile;
import org.springframework.stereotype.Repository;

@Repository
public interface ProfileRepository extends ParentRepository<Profile,Long>{
}
