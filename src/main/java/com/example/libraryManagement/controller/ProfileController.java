package com.example.libraryManagement.controller;

import com.example.libraryManagement.model.dto.fullInfo.ProfileFullInfoDto;
import com.example.libraryManagement.model.dto.ProfileMinInfoDto;
import com.example.libraryManagement.model.dto.form.UpsertProfileForm;
import com.example.libraryManagement.query.params.GetProfileParams;
import com.example.libraryManagement.service.IProfileService;
import com.example.libraryManagement.service.serviceImpl.ProfileService;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.data.domain.Pageable;
import org.springframework.data.web.PagedResourcesAssembler;
import org.springframework.hateoas.EntityModel;
import org.springframework.hateoas.PagedModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@RestController
@RequestMapping("/api/v1/profile")
@RequiredArgsConstructor
public class ProfileController {
    private final IProfileService profileService;
    private final PagedResourcesAssembler<ProfileMinInfoDto> profileMinInfoDtoPagedResourcesAssembler;

    private final Logger logger = LoggerFactory.getLogger(ProfileController.class);

    @PostMapping(path = "/member", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<ProfileFullInfoDto> createMemberProfile(
            @RequestPart("form")UpsertProfileForm upsertProfileForm,
            @RequestPart(value = "file", required = false)MultipartFile file
    ) {
       return ResponseEntity.ok(profileService.createMemberProfile(upsertProfileForm,file));
    }

    @PostMapping(path = "/librarian", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<ProfileFullInfoDto> createLibrarianProfile(
            @RequestPart("form")UpsertProfileForm upsertProfileForm,
            @RequestPart(value = "file", required = false)MultipartFile file
    ) {
        return ResponseEntity.ok(profileService.createLibrarianProfile(upsertProfileForm,file));
    }

    @PostMapping(path = "/manager", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<ProfileFullInfoDto> createManagerProfile(
            @RequestPart("form")UpsertProfileForm upsertProfileForm,
            @RequestPart(value = "file", required = false)MultipartFile file
    ) {
        logger.info(upsertProfileForm.toString());
        return ResponseEntity.ok(profileService.createManagerProfile(upsertProfileForm,file));
    }

    @PutMapping(value = "/current-user-change", consumes = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> changeCurrentUserInfo( @RequestBody UpsertProfileForm upsertProfileForm) {
        profileService.changeCurrentUserProfile(upsertProfileForm);
        return ResponseEntity.status(HttpStatus.OK).build();
    }

    @GetMapping("/fullInfo/{id}")
    public ResponseEntity<ProfileFullInfoDto> getFullInfoProfileById(
            @PathVariable("id") Long id
    ){
        return ResponseEntity.ok(profileService.getFullInfoProfile(id));
    }

    @GetMapping("/member")
    public ResponseEntity<PagedModel<EntityModel<ProfileMinInfoDto>>> getMemberProfile(
            GetProfileParams getProfileParams,
            Pageable pageable
    ){
        PagedModel<EntityModel<ProfileMinInfoDto>> pagedModel = profileMinInfoDtoPagedResourcesAssembler.toModel(
                profileService.getMemberProfile(getProfileParams, pageable)
        );
        return ResponseEntity.ok(pagedModel);
    }

    @GetMapping("/librarian")
    public ResponseEntity<PagedModel<EntityModel<ProfileMinInfoDto>>> getLibrarianProfile(
            GetProfileParams getProfileParams,
            Pageable pageable
    ){
        PagedModel<EntityModel<ProfileMinInfoDto>> pagedModel = profileMinInfoDtoPagedResourcesAssembler.toModel(
                profileService.getLibrarianProfile(getProfileParams, pageable)
        );
        return ResponseEntity.ok(pagedModel);
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateProfile(
            @RequestBody UpsertProfileForm upsertProfileForm,
            @PathVariable("id") Long id
    ) {
        return ResponseEntity.ok(profileService.updateProfile(upsertProfileForm, id));
    }
    @DeleteMapping("/id")
    public ResponseEntity<?> deleteProfileById (@PathVariable("id") Long id){
        profileService.deleteProfile(id);
        return ResponseEntity.ok("delete success");
    }

    @DeleteMapping
    public ResponseEntity<?> deleteProfilesInIds(@RequestBody List<Long> ids){
        profileService.deleteProfilesInIds(ids);
        return ResponseEntity.ok("delete sucess");
    }
}
