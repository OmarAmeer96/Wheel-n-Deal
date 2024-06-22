package com.graduationproject.DTOs;

import lombok.Data;

@Data
public class UserCountDTO {
    private int day;
    private String month;
    private long count;

    public UserCountDTO(String date, long count) {
        String[] parts = date.split(" ");
        this.day = Integer.parseInt(parts[0]);
        this.month = parts[1];
        this.count = count;
    }

}