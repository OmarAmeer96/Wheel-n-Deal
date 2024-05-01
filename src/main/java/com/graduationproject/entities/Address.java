package com.graduationproject.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
public class Address {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @NotBlank
    @NotNull
    private String addressName;
    @NotBlank
    @NotNull
    private String address;


    @ManyToOne
    @JoinColumn(name = "user_id")
    @NotNull(message = "User must not be null")
    @JsonBackReference
    private User user;
}
