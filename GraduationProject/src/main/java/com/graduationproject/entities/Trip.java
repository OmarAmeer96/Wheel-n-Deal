package com.graduationproject.entities;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * Represents a trip entity in the application.
 */
@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class Trip {
    /** The unique identifier for the trip. */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    /** The starting location of the trip. */
    @Column(name = "moving_from")
    private String from;

    /** The destination of the trip. */
    @Column(name = "goes_to")
    private String to;

    /** The list of paths for the trip. */
    private List<String> paths;

    /** The day of the trip. */
    private String day;

    /** The starting time of the trip. */
    private String startsAt;

    /** The ending time of the trip. */
    private String endsAt;

    /** The capacity of the trip (number of available seats). */
    private int capacity;

    /** The user who created the trip. */
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}