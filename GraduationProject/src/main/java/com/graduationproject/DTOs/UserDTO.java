package com.graduationproject.DTOs;

import com.graduationproject.entities.*;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class UserDTO {
    private Integer id;
    private String phoneNumber;
    private String username;
    private Long amount;
    private Gender gender;
    private String profilePictureUrl;
    private String nationalId;
    private Integer totalDelivers;
    private Integer cancelDelivers;
}
