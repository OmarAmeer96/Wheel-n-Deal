package com.graduationproject.entities;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
public class Trip {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NotBlank
    @Column(name = "moving_from")
    @NotNull(message = "Starting location must not be null")
    @Size(min = 3, max = 100, message = "Starting location must be between 3 and 100 characters long")
    private String from;

    @NotBlank
    @Column(name = "goes_to")
    @NotNull(message = "Destination must not be null")
    @Size(min = 3, max = 100, message = "Destination must be between 3 and 100 characters long")
    private String to;

    @NotNull(message = "Paths must not be null")
    @Size(min = 1, message = "At least one path must be provided")
    private List<String> paths;

    @NotBlank
    @Pattern(regexp = "^\\d{4}-\\d{2}-\\d{2}$", message = "Invalid day format. Use yyyy-MM-dd")
    private String day;

    @NotBlank
    @Pattern(regexp = "^\\d{2}:\\d{2}$", message = "Invalid time format. Use HH:mm")
    private String startsAt;

    @NotBlank
    @Pattern(regexp = "^\\d{2}:\\d{2}$", message = "Invalid time format. Use HH:mm")
    private String endsAt;

    @Min(value = 1, message = "Capacity must be greater than 0")
    private Integer capacity;

    @ManyToOne
    @JoinColumn(name = "user_id")
    @NotNull(message = "User must not be null")
    private User user;
}