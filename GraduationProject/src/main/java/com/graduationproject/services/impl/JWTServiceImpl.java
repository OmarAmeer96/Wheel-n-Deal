package com.graduationproject.services.impl;

import com.graduationproject.services.JWTService;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.io.Decoders;
import io.jsonwebtoken.security.Keys;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.security.Key;
import java.util.Date;
import java.util.HashMap;
import java.util.function.Function;

/**
 * Implementation of the JWTService interface for generating and validating JWT tokens.
 */
@Service
public class JWTServiceImpl implements JWTService {

    /**
     * Generates a JWT token for the given UserDetails.
     * @param userDetails The UserDetails of the user
     * @return The generated JWT token
     */
    public String generateToken(UserDetails userDetails){
        return Jwts.builder().setSubject(userDetails.getUsername())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 24))
                .signWith(getSigningKey() , SignatureAlgorithm.HS256)
                .compact();
    }

    /**
     * Generates a refresh token for the given UserDetails.
     * @param extraClaims Extra claims to include in the token
     * @param userDetails The UserDetails of the user
     * @return The generated refresh token
     */
    public String generateRefreshToken(HashMap<String, Object> extraClaims, UserDetails userDetails) {
        return Jwts.builder().setClaims(extraClaims).setSubject(userDetails.getUsername())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + 604800000))
                .signWith(getSigningKey(),SignatureAlgorithm.HS256)
                .compact();
    }

    /**
     * Retrieves the signing key for JWT.
     * @return The signing key
     */
    private Key getSigningKey() {
        byte[] key = Decoders.BASE64.decode("Y2hvaWNlZmlnaHRpbmdwcm9iYWJseXJheXNkcmllZGFsc290ZWFtbGl0dGxlYXZvaWQ");
        return Keys.hmacShaKeyFor(key);
    }

    /**
     * Extracts a particular claim from the token.
     * @param token The JWT token
     * @param claimsResolver Function to extract the claim
     * @param <T> Type of the claim
     * @return The extracted claim
     */
    private <T> T extractClaims(String token , Function<Claims,T> claimsResolver){
        final Claims claims = extractAllClaims(token);
        return claimsResolver.apply(claims);
    }

    /**
     * Extracts all claims from the token.
     * @param token The JWT token
     * @return All claims in the token
     */
    private Claims extractAllClaims(String token) {
        return Jwts.parserBuilder().setSigningKey(getSigningKey()).build().parseClaimsJws(token).getBody();
    }

    /**
     * Extracts the username (subject) from the token.
     * @param token The JWT token
     * @return The username extracted from the token
     */
    public String extractUserName(String token){
        return extractClaims(token , Claims ::getSubject);
    }

    /**
     * Checks if the token is valid.
     * @param token The JWT token
     * @param userDetails UserDetails of the user
     * @return True if the token is valid, false otherwise
     */
    public boolean isTokenValid(String token , UserDetails userDetails){
        final String username = extractUserName(token);
        return (username.equals(userDetails.getUsername()) && !isTokenExpired(token));
    }

    /**
     * Checks if the token has expired.
     * @param token The JWT token
     * @return True if the token has expired, false otherwise
     */
    private boolean isTokenExpired(String token) {
        return extractClaims(token , Claims ::getExpiration).before(new Date());
    }
}