package com.graduationproject.DTOs;

import lombok.Data;
import lombok.RequiredArgsConstructor;

/**
 * Data Transfer Object (DTO) representing a response.
 */
@Data
@RequiredArgsConstructor
public class Response {
    /** The ID of the response. */
    private Integer id;

    /** The response message. */
    private String response;
}