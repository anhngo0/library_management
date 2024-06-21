package com.example.libraryManagement.service.serviceImpl;

import com.example.libraryManagement.exeption.ResourceNotFoundException;
import com.example.libraryManagement.mapper.ProfileMapper;
import com.example.libraryManagement.model.dto.fullInfo.ProfileFullInfoDto;
import com.example.libraryManagement.model.dto.ProfileMinInfoDto;
import com.example.libraryManagement.model.dto.form.UpsertProfileForm;
import com.example.libraryManagement.model.entity.FileDescription;
import com.example.libraryManagement.model.entity.Profile;
import com.example.libraryManagement.model.entity.UserRole;
import com.example.libraryManagement.model.repository.ProfileRepository;
import com.example.libraryManagement.query.params.GetProfileParams;
import com.example.libraryManagement.query.predicate.ProfilePredicate;
import com.example.libraryManagement.service.IFileStorageService;
import com.example.libraryManagement.service.IProfileService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.concurrent.CompletableFuture;

@Service
@RequiredArgsConstructor
public class ProfileService implements IProfileService {
    private final ProfileRepository profileRepository;
    private final ProfileMapper profileMapper;
    private final IFileStorageService fileStorageService;
    @Override
    @Transactional
    public ProfileFullInfoDto createMemberProfile(UpsertProfileForm upsertProfileForm, MultipartFile file) {
        Profile profile = profileMapper.toEntity(upsertProfileForm);
        profile.setUserRole(UserRole.MEMBER);
        profile = profileRepository.save(profile);
        Profile newProfile = profile;
        CompletableFuture.runAsync(()-> {
           fileStorageService.uploadMultipleFiles(
                   newProfile.getId(),
                   Profile.class.getSimpleName(),
                   FileDescription.IMAGE,
                   file
           );
        });
        return profileMapper.toFullInfoDto(newProfile);
    }

    @Override
    @Transactional
    public ProfileFullInfoDto createLibrarianProfile(UpsertProfileForm upsertProfileForm, MultipartFile file) {
        Profile profile = profileMapper.toEntity(upsertProfileForm);
        profile.setUserRole(UserRole.LIBRARIAN);
        profile = profileRepository.save(profile);
        Profile newProfile = profile;
        CompletableFuture.runAsync(()-> {
            fileStorageService.uploadMultipleFiles(
                    newProfile.getId(),
                    Profile.class.getSimpleName(),
                    FileDescription.IMAGE,
                    file
            );
        });
        return profileMapper.toFullInfoDto(newProfile);
    }

    @Override
    @Transactional
    public ProfileFullInfoDto createManagerProfile(UpsertProfileForm upsertProfileForm, MultipartFile file) {
        Profile profile = profileMapper.toEntity(upsertProfileForm);
        profile.setUserRole(UserRole.MANAGER);
        profile = profileRepository.save(profile);
        Profile newProfile = profile;
        CompletableFuture.runAsync(()-> {
            fileStorageService.uploadMultipleFiles(
                    newProfile.getId(),
                    Profile.class.getSimpleName(),
                    FileDescription.IMAGE,
                    file
            );
        });
        return profileMapper.toFullInfoDto(newProfile);
    }

    @Override
    public ProfileFullInfoDto getFullInfoProfile(Long id) {
        Profile profile = profileRepository.findById(id).orElseThrow(()-> new ResourceNotFoundException("resource not found"));
        return profileMapper.toFullInfoDto(profile);
    }

    @Override
    public Page<ProfileMinInfoDto> getMemberProfile(GetProfileParams getProfileParams, Pageable pageable) {
        Page<ProfileMinInfoDto> page = profileRepository.findAll(
                ProfilePredicate.getMemberProfiles(getProfileParams),
                pageable
        ).map(profileMapper::toMinInfoDto);
        return page;
    }

    @Override
    public Page<ProfileMinInfoDto> getLibrarianProfile(GetProfileParams getProfileParams, Pageable pageable) {
        Page<ProfileMinInfoDto> page = profileRepository.findAll(
                ProfilePredicate.getLibrarianProfiles(getProfileParams),
                pageable
        ).map(profileMapper::toMinInfoDto);
        return page;
    }

    @Override
    public ProfileFullInfoDto updateProfile(UpsertProfileForm upsertProfileForm, Long id) {
        Profile profile = profileRepository.findById(id).orElseThrow(()-> new ResourceNotFoundException("resource not found"));
        Profile updatedProfile = profileMapper.toEntity_update(upsertProfileForm,profile);
        updatedProfile = profileRepository.save(updatedProfile);
        return profileMapper.toFullInfoDto(updatedProfile);
    }

    @Override
    public void deleteProfile(Long id) {
        try {
            profileRepository.deleteById(id);
        } catch (RuntimeException e){
            throw new ResourceNotFoundException("resource not found exception");
        }
    }

    @Override
    public void deleteProfilesInIds(List<Long> ids) {
        try {
            profileRepository.deleteAllById(ids);
        } catch (RuntimeException e){
            throw new ResourceNotFoundException("resource not found exception");
        }
    }
}
