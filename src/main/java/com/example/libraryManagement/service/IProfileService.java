package com.example.libraryManagement.service;

import com.example.libraryManagement.model.dto.fullInfo.ProfileFullInfoDto;
import com.example.libraryManagement.model.dto.ProfileMinInfoDto;
import com.example.libraryManagement.model.dto.form.UpsertProfileForm;
import com.example.libraryManagement.query.params.GetProfileParams;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface IProfileService {
    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"PROFILE.CREATE\")")
    ProfileFullInfoDto createMemberProfile(UpsertProfileForm upsertProfileForm, MultipartFile file);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    ProfileFullInfoDto createLibrarianProfile(UpsertProfileForm upsertProfileForm, MultipartFile file);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER')")
    ProfileFullInfoDto createManagerProfile(UpsertProfileForm upsertProfileForm, MultipartFile file);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"PROFILE.READ\")")
    ProfileFullInfoDto getFullInfoProfile(Long id);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"PROFILE.READ\")")
    Page<ProfileMinInfoDto> getMemberProfile(GetProfileParams getProfileParams, Pageable pageable);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"PROFILE.READ\")")
    Page<ProfileMinInfoDto> getLibrarianProfile(GetProfileParams getProfileParams, Pageable pageable);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"PROFILE.UPDATE\")")
    ProfileFullInfoDto updateProfile(UpsertProfileForm upsertProfileForm, Long id);

    @PreAuthorize("hasAnyRole('ROLE_MANAGER','ROLE_LIBRARIAN') or hasAuthorities(\"PROFILE.DELETE\")")
    void deleteProfile(Long id);

    void deleteProfilesInIds(List<Long> ids);
}
