package com.graduationproject.DTOs;

import com.graduationproject.entities.Gender;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Data;

import java.util.List;

@Data
public class AiCommuterDto {
    private Integer commuterId;
    private String city;
    private Gender gender;
    private Double totalRate;
    private List<TripDTO> trips;

    @Data
    public static class TripDTO {
        private Integer id;
        private String from;
        private String to;

        public TripDTO(Integer id, String from, String to) {
            this.id = id;
            this.from = from;
            this.to = to;
        }
    }
}
