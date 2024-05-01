package com.graduationproject.DTOs;

import lombok.Data;
import java.util.List;

@Data
public class CommuterProfileDTO {
    private String username;
    private double totalRate;
    private int totalDelivers;
    private int cancelDelivers;
    private String phoneNumber;
    private String commuterPhotoURL;
    private List<ProfileTripDetailsDTO> profileTripDetailsDTOs;
    private List<ProfileReviewsDTO> profileReviewsDTOS;
}
