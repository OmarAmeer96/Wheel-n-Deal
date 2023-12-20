package com.GraduationProject.test.DTOs;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
public class LoginDTO {
    private String name;
    private String password;
}
