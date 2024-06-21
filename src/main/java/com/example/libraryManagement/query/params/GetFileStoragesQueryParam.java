package com.example.libraryManagement.query.params;

import com.example.libraryManagement.model.entity.FileDescription;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GetFileStoragesQueryParam  {
    private Long  associatedEntityId;
    private String associatedEntityType;
    private FileDescription fileDescription;
}
