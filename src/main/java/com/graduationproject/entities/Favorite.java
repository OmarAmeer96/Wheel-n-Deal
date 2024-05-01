package com.graduationproject.entities;

import com.fasterxml.jackson.annotation.JsonBackReference;
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
    @JsonBackReference
    @NotNull(message = "User must not be null")
    private User user;

    @ManyToOne
    @JoinColumn(name = "favorite_user_id")
    @JsonBackReference
    @NotNull(message = "Favorite user must not be null")
    private User favoriteUser;
}
