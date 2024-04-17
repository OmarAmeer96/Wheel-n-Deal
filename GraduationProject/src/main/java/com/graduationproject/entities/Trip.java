package com.graduationproject.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
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
    private Integer id;

    /** The starting location of the trip. */
    @Column(name = "moving_from")
    @NotNull(message = "Starting location must not be null")
    @Size(min = 3, max = 100, message = "Starting location must be between 3 and 100 characters long")
    private String from;

    /** The destination of the trip. */
    @Column(name = "goes_to")
    @NotNull(message = "Destination must not be null")
    @Size(min = 3, max = 100, message = "Destination must be between 3 and 100 characters long")
    private String to;

    /** The list of paths for the trip. */
    @NotNull(message = "Paths must not be null")
    @Size(min = 1, message = "At least one path must be provided")
    private List<String> paths;

    /** The day of the trip. */
    @Pattern(regexp = "^\\d{4}-\\d{2}-\\d{2}$", message = "Invalid day format. Use yyyy-MM-dd")
    private String day;

    /** The starting time of the trip. */
    @Pattern(regexp = "^\\d{2}:\\d{2}$", message = "Invalid time format. Use HH:mm")
    private String startsAt;

    /** The ending time of the trip. */
    @Pattern(regexp = "^\\d{2}:\\d{2}$", message = "Invalid time format. Use HH:mm")
    private String endsAt;

    /** The capacity of the trip (number of available seats). */
    @Min(value = 1, message = "Capacity must be greater than 0")
    private Integer capacity;

    /** The user who created the trip. */
    @ManyToOne
    @JoinColumn(name = "user_id")
    @NotNull(message = "User must not be null")
    private User user;
}