package com.example.libraryManagement.auth;

import com.example.libraryManagement.model.dto.AccountDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
public class AuthController {
    @Autowired
    private AuthService authService;

    @PostMapping(path = "/login", consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
    public ResponseEntity<AuthenticationResponse> login(@ModelAttribute LoginForm loginForm){
        return ResponseEntity.ok(authService.authenticate(loginForm));
    }

    @PostMapping("/refresh-token")
    public ResponseEntity<AuthenticationResponse> refreshToken(HttpServletRequest request){
        return ResponseEntity.ok(authService.refreshToken(request));
    }

    @GetMapping("/current-user")
    public ResponseEntity<AccountDto> getCurrentUser(){
        return ResponseEntity.ok(authService.getCurrentUser());
    }
}
