package com.graduationproject.DTOs;

import lombok.Data;
import java.util.List;

@Data
public class CommuterProfileDTO {
    private String username;
    private Double totalRate;
    private Integer totalDelivers;
    private Integer cancelDelivers;
    private String phoneNumber;
    private String commuterPhotoURL;
    private List<ProfileTripDetailsDTO> profileTripDetailsDTOs;
    private List<ProfileReviewsDTO> profileReviewsDTOS;
}