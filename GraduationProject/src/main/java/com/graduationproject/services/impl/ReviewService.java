package com.graduationproject.services.impl;

import com.graduationproject.DTOs.ReviewDTO;
import com.graduationproject.entities.Review;
import com.graduationproject.entities.Role;
import com.graduationproject.entities.User;
import com.graduationproject.repositories.ReviewRepository;
import com.graduationproject.repositories.UserRepository;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Service
@Data
@RequiredArgsConstructor
public class ReviewService {
    private final ReviewRepository reviewRepository;
    private final UserRepository userRepository;


    public ResponseEntity<String> submitOrEditReview(ReviewDTO reviewDTO){
        if(reviewDTO != null) {
            String comment = reviewDTO.getComment();

            List<String> VERY_BAD_WORDS = Arrays.asList("fuck","2g1c", "2 girls 1 cup", "acrotomophilia", "alabama hot pocket", "alaskan pipeline",
                    "anilingus", "anus", "apeshit", "arsehole", "ass", "asshole", "assmunch",
                    "auto erotic", "autoerotic", "babeland", "baby batter", "baby juice", "ball gag",
                    "ball gravy", "ball kicking", "ball licking", "ball sack", "ball sucking", "bangbros",
                    "bangbus", "bareback", "barely legal", "barenaked", "bastard", "bastardo", "bastinado",
                    "bbw", "bdsm", "beaner", "beaners", "beaver cleaver", "beaver lips", "beastiality",
                    "bestiality", "big black", "big breasts", "big knockers", "big tits", "bimbos",
                    "birdlock", "bitch", "bitches", "black cock", "blonde action", "blonde on blonde action",
                    "blowjob", "blow job", "blow your load", "blue waffle", "blumpkin", "bollocks",
                    "bondage", "boner", "boob", "boobs", "booty call", "brown showers", "brunette action",
                    "bukkake", "bulldyke", "bullet vibe", "bullshit", "bung hole", "bunghole", "busty",
                    "butt", "buttcheeks", "butthole", "camel toe", "camgirl", "camslut", "camwhore",
                    "carpet muncher", "carpetmuncher", "chocolate rosebuds", "cialis", "circlejerk",
                    "cleveland steamer", "clit", "clitoris", "clover clamps", "clusterfuck", "cock",
                    "cocks", "coprolagnia", "coprophilia", "cornhole", "coon", "coons", "creampie",
                    "cum", "cumming", "cumshot", "cumshots", "cunnilingus", "cunt", "darkie", "date rape",
                    "daterape", "deep throat", "deepthroat", "dendrophilia", "dick", "dildo", "dingleberry",
                    "dingleberries", "dirty pillows", "dirty sanchez", "doggie style", "doggiestyle",
                    "doggy style", "doggystyle", "dog style", "dolcett", "domination", "dominatrix", "dommes",
                    "donkey punch", "double dong", "double penetration", "dp action", "dry hump", "dvda",
                    "eat my ass", "ecchi", "ejaculation", "erotic", "erotism", "escort", "eunuch", "fag",
                    "faggot", "fecal", "felch", "fellatio", "feltch", "female squirting", "femdom", "figging",
                    "fingerbang", "fingering", "fisting", "foot fetish", "footjob", "frotting", "fuck",
                    "fuck buttons", "fuckin", "fucking", "fucktards", "fudge packer", "fudgepacker",
                    "futanari", "gangbang", "gang bang", "gay sex", "genitals", "giant cock", "girl on",
                    "girl on top", "girls gone wild", "goatcx", "goatse", "god damn", "gokkun", "golden shower",
                    "goodpoop", "goo girl", "goregasm", "grope", "group sex", "g-spot", "guro", "hand job",
                    "handjob", "hard core", "hardcore", "hentai", "homoerotic", "honkey", "hooker", "horny",
                    "hot carl", "hot chick", "how to kill", "how to murder", "huge fat", "humping", "incest",
                    "intercourse", "jack off", "jail bait", "jailbait","anal", "jelly donut", "jerk off", "jigaboo",
                    "jiggaboo", "jiggerboo", "jizz", "juggs", "kike", "kinbaku", "kinkster", "kinky", "knobbing",
                    "leather restraint", "leather straight jacket", "lemon party", "livesex", "lolita",
                    "lovemaking", "make me come", "male squirting", "masturbate", "masturbating", "masturbation",
                    "menage a trois", "milf", "missionary position", "mong", "motherfucker", "mound of venus",
                    "mr hands", "muff diver", "muffdiving", "nambla", "nawashi", "negro", "neonazi", "nigga",
                    "nigger", "nig nog", "nimphomania", "nipple", "nipples", "nsfw", "nsfw images", "nude",
                    "nudity", "nutten");


            if (containsVeryBadWords(comment, VERY_BAD_WORDS)) {
                return ResponseEntity.badRequest().body("Your review contains inappropriate language. Please revise.");
            }
        }

        Integer reviewerId = reviewDTO.getReviewerId();
        Integer revieweeId = reviewDTO.getRevieweeId();

        if(reviewDTO != null){
            if(IsReviewerReviewedBefore(reviewerId,revieweeId) ) {
                return ResponseEntity.badRequest().body("You have already made a review for this commuter before.");
            }
        }

        Integer reviewId = reviewDTO.getId();
        if (reviewId != null) {
            Optional<Review> optionalReview = reviewRepository.findById(reviewId);
            if (optionalReview.isPresent()) {
                Review review = optionalReview.get();
                updateReviewFromDTO(review, reviewDTO);
                reviewRepository.save(review);
                return ResponseEntity.ok("Review updated successfully");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Review not found with ID: " + reviewDTO.getId());
            }
        } else {
            submitReviewFromDTO(reviewDTO);
            return ResponseEntity.ok("Review submitted successfully");
        }
    }

    private boolean IsReviewerReviewedBefore(Integer reviewerId, Integer revieweeId) {
        Review review = reviewRepository.findByReviewerIdAndRevieweeId(reviewerId,revieweeId);
        return review != null;
    }

    private boolean containsVeryBadWords(String comment, List<String> veryBadWords) {
        for (String badWord : veryBadWords) {
            if (comment.toLowerCase().contains(badWord)) {
                return true;
            }
        }
        return false;
    }


    public String deleteReview(int reviewId){
        reviewRepository.deleteById(reviewId);
        return "Review deleted Successfully";
    }


    private Review submitReviewFromDTO(ReviewDTO reviewDTO){
        Optional<User> optioanlReviewer = userRepository.findById(reviewDTO.getReviewerId());
        Optional<User> optioanlReviewee = userRepository.findById(reviewDTO.getRevieweeId());
        if (optioanlReviewer.isEmpty()) {
            throw new RuntimeException("User not found with ID: " + reviewDTO.getReviewerId());
        } else if (optioanlReviewee.isEmpty()) {
            throw new RuntimeException("User not found with ID: " + reviewDTO.getRevieweeId());
        }
        Review review = new Review();
        updateReviewFromDTO(review,reviewDTO);
        User reviewer = optioanlReviewer.get();
        User reviewee = optioanlReviewee.get();
        review.setReviewer(reviewer);
        review.setReviewee(reviewee);
        if(reviewee.getRole() == Role.COMMUTER){
            return reviewRepository.save(review);
        }
        else throw new RuntimeException("Reviewee must be Commuter to submit the review");
    }

    private void updateReviewFromDTO(Review review,ReviewDTO reviewDTO){
        review.setRate(reviewDTO.getRate());
        review.setComment(reviewDTO.getComment());
    }
}
