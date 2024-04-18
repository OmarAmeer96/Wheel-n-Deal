package com.graduationproject.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.*;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
public class Favorite {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    @NotNull(message = "User must not be null")
    private User user;

    @ManyToOne
    @JoinColumn(name = "favorite_user_id")
    @NotNull(message = "Favorite user must not be null")
    private User favoriteUser;
}