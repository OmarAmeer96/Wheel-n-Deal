package com.graduationproject.repositories;

import com.graduationproject.entities.Token;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;
import java.util.Optional;

/**
 * Repository interface for managing token entities in the database.
 */
public interface TokenRepository extends JpaRepository<Token,Integer> {

    /**
     * Retrieves all valid tokens for a given user.
     * @param userId The ID of the user.
     * @return A list of valid tokens for the user.
     */
    @Query("""
            select t from Token t inner join User u on t.user.id = u.id
            where u.id =:userId and (t.expired =false or t.revoked=false)
            """)
    List<Token> findAllValidTokensByUser(Integer userId);

    /**
     * Finds a token by its token string.
     * @param token The token string.
     * @return An optional containing the token if found, otherwise empty.
     */
    Optional<Token> findByToken(String token);
}