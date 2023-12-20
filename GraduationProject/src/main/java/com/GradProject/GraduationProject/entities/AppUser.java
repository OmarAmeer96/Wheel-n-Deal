package com.GraduationProject.test.entities;

import jakarta.persistence.*;
import lombok.*;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "users")
public class AppUser {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;

    @NotNull
    @NotEmpty(message = "Name is required")
    @Column(name = "user_name", unique = true)
    private String name;

    @NotNull
    @Size(min = 6, max = 15)
    @Column(name = "password")
    @NotEmpty(message = "Password is required")
    private String password;

    @NotNull
    @NotEmpty(message = "Phone number is required")
    @Column(name = "phone_number", unique = true, length = 10)
    private String phoneNumber;
}
