package com.graduationproject.DTOs;

import lombok.Data;

import java.util.List;

@Data
public class TripDTO {
    private Integer id;
    private String from;
    private String to;
    private List<String> paths;
    private String day;
    private String startsAt;
    private String endsAt;
    private int capacity;
    private int userId;
}