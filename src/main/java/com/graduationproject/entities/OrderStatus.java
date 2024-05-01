package com.graduationproject.entities;

public enum OrderStatus {
    NOT_ACTIVE,
    PENDING,

    //TODO : handle the change from pending to confirmed before 3h from the time
    CONFIRMED,
    IN_PROGRESS,
    SUCCESS,
    FAILED,
    RETURNED
}
