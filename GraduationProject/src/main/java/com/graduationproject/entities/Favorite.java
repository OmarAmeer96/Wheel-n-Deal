package com.graduationproject.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class Favorite {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    //@JsonBackReference
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    // @JsonBackReference
    @ManyToOne
    @JoinColumn(name = "favorite_user_id")
    private User favoriteUser;
}

