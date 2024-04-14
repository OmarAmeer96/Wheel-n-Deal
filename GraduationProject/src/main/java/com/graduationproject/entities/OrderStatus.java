package com.graduationproject.entities;

/**
 * Enumeration representing the status of orders in the application.
 */
public enum OrderStatus {
    /** Order is not active. */
    NOT_ACTIVE,
    /** Order is pending. */
    PENDING,
    /** Order is in progress. */
    IN_PROGRESS,
    /** Order was successful. */
    SUCCESS,
    /** Order has failed. */
    FAILED
}
