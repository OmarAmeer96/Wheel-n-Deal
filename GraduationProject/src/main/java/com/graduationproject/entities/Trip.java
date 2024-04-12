package com.graduationproject.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Trip {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "moving_from")
    private String from;
    @Column(name = "goes_to")
    private String to;
    private List<String> paths;
    private String day;
    private String startsAt;
    private String endsAt;
    private int capacity;
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}