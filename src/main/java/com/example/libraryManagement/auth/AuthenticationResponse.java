package com.example.libraryManagement.auth;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AuthenticationResponse {
    @JsonProperty("access_token") //serialize into json object
    private String accessToken;

    @JsonProperty("refresh_token")
    private String refreshToken;
}
