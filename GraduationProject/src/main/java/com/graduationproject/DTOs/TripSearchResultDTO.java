package com.graduationproject.DTOs;

import lombok.Data;

/**
 * Data Transfer Object (DTO) representing the search result of a trip.
 */
@Data
public class TripSearchResultDTO {
    /** The username of the commuter associated with the trip. */
    private String username;

    /** The phone number of the commuter associated with the trip. */
    private String phoneNumber;

    /** The starting location of the trip. */
    private String from;

    /** The destination of the trip. */
    private String to;

    /** The URL of the profile photo of the commuter associated with the trip. */
    private String commuterProfilePhotoURL;
}