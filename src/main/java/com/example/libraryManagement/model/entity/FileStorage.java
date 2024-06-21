package com.example.libraryManagement.model.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
@Table(name = "file_storage")
public class FileStorage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(nullable = false)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false)
    private String extension;

    private String contentType;

    @Column(nullable = false)
    private String associatedEntityType;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private FileDescription description;

    @Column(nullable = false)
    private Long associatedEntityId;

    @Lob
    @Column(nullable = false,length = 100000 )
    byte[] data;
}
