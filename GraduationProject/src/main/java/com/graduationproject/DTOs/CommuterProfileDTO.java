package com.graduationproject.DTOs;

import lombok.Data;
import java.util.List;

/**
 * Data Transfer Object (DTO) representing the profile of a commuter.
 */
@Data
public class CommuterProfileDTO {
    /** The username of the commuter. */
    private String username;

    /** The total rating of the commuter. */
    private double totalRate;

    /** The total number of deliveries made by the commuter. */
    private int totalDelivers;

    /** The number of deliveries canceled by the commuter. */
    private int cancelDelivers;

    /** The phone number of the commuter. */
    private String phoneNumber;

    /** The URL of the commuter's photo. */
    private String commuterPhotoURL;

    /** The list of trip details associated with the commuter's profile. */
    private List<ProfileTripDetailsDTO> profileTripDetailsDTOs;

    /** The list of reviews associated with the commuter's profile. */
    private List<ProfileReviewsDTO> profileReviewsDTOS;
}