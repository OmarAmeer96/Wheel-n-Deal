package com.graduationproject.DTOs.paymobPaymentDTOs;

import lombok.Data;

/**
 * Data Transfer Object (DTO) representing billing data for Paymob payment.
 */
@Data
public class BillingData {
    /** The apartment number. */
    private String apartment = "803";

    /** The email address. */
    private String email = "claudette09@exa.com";

    /** The floor number. */
    private String floor = "42";

    /** The first name. */
    private String first_name = "Clifford";

    /** The street. */
    private String street = "Ethan Land";

    /** The building number. */
    private String building = "8028";

    /** The phone number. */
    private String phone_number = "+86(8)9135210487";

    /** The shipping method. */
    private String shipping_method = "PKG";

    /** The postal code. */
    private String postal_code = "01898";

    /** The city. */
    private String city = "Jaskolskiburgh";

    /** The country. */
    private String country = "CR";

    /** The last name. */
    private String last_name = "Nicolas";

    /** The state. */
    private String state = "Utah";
}