package com.GraduationProject.test.DTOs;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@AllArgsConstructor
@Getter
@Setter
public class UserDTO {
    private Long id;
    private String name;
    private String password;
    private String phoneNumber;
}
