package com.graduationproject.DTOs;

import lombok.Data;

import java.util.List;

/**
 * Data Transfer Object (DTO) representing a trip.
 */
@Data
public class TripDTO {
    /** The ID of the trip. */
    private Integer id;

    /** The starting location of the trip. */
    private String from;

    /** The destination of the trip. */
    private String to;

    /** The list of paths for the trip. */
    private List<String> paths;

    /** The day of the trip. */
    private String day;

    /** The start time of the trip. */
    private String startsAt;

    /** The end time of the trip. */
    private String endsAt;

    /** The capacity of the trip. */
    private int capacity;

    /** The ID of the user associated with the trip. */
    private int userId;
}