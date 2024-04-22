package com.graduationproject.DTOs;

import lombok.Data;

@Data
public class SignInRequest {
    private String username;
    private String password;
}