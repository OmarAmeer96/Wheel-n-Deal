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

@Service
public class JWTServiceImpl implements JWTService {
    public String generateToken(UserDetails userDetails){
        return Jwts.builder().setSubject(userDetails.getUsername())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + 1000 * 60 * 24))
                .signWith(getSiginKey() , SignatureAlgorithm.HS256)
                .compact();
    }

    public String generateRefreshToken(HashMap<String, Object> extraClaims, UserDetails userDetails) {
        return Jwts.builder().setClaims(extraClaims).setSubject(userDetails.getUsername())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + 604800000))
                .signWith(getSiginKey(),SignatureAlgorithm.HS256)
                .compact();
    }


    private Key getSiginKey() {
        byte[] key = Decoders.BASE64.decode("Y2hvaWNlZmlnaHRpbmdwcm9iYWJseXJheXNkcmllZGFsc290ZWFtbGl0dGxlYXZvaWQ");
        return Keys.hmacShaKeyFor(key);
    }
    /* And We use this to get a particular claim
    * By passing to this method the Token
    * and The Function that we will use to get particular part of the claim */
    private <T> T extractClaims(String token , Function<Claims,T> claimsResolver){
        final Claims claims = extractAllClaims(token);
        return claimsResolver.apply(claims);
    }

    //This method Will return All Calims
    private Claims extractAllClaims(String token) {
        return Jwts.parserBuilder().setSigningKey(getSiginKey()).build().parseClaimsJws(token).getBody();
    }
    //This method will extract the username(in our system is the email) from the token
    public String extractUserName(String token){
        return extractClaims(token , Claims ::getSubject);
    }

    /*This method will valid if the token is valid or not
    By checking if the username that comes with the token
    is the same user name which comes with the UserDetails from the DB
    and is the Token is still valid or not
    */
    public boolean isTokenValid(String token , UserDetails userDetails){
        final String username = extractUserName(token);
        return (username.equals(userDetails.getUsername()) && !isTokenExpired(token));
    }


    //This method for checking The Expiration of the token
    private boolean isTokenExpired(String token) {
        return extractClaims(token , Claims ::getExpiration).before(new Date());
    }


}

