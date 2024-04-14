package com.graduationproject.DTOs;

import lombok.Data;

/**
 * Data Transfer Object (DTO) representing trip details in a user's profile.
 */
@Data
public class ProfileTripDetailsDTO {
    /** The starting location of the trip. */
    private String from;

    /** The destination of the trip. */
    private String to;

    /** The day of the trip. */
    private String day;

    /** The start time of the trip. */
    private String startsAt;

    /** The end time of the trip. */
    private String endsAt;

    /** The capacity of the trip. */
    private int capacity;
}