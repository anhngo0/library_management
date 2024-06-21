package com.example.libraryManagement.model.repository;

import com.example.libraryManagement.model.entity.Role;
import org.springframework.stereotype.Repository;

@Repository
public interface RoleRepository extends ParentRepository<Role,Long>{
}
