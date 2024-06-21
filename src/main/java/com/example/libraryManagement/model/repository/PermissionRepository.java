package com.example.libraryManagement.model.repository;

import com.example.libraryManagement.model.entity.Permission;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.Set;

@Repository
public interface PermissionRepository extends ParentRepository<Permission,Long>{
    Set<Permission> findByNameInIgnoreCase(Collection<String> stringPermissions);
}
