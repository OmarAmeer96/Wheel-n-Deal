package com.graduationproject.utils;

import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * Utility class for handling file upload and generating file URLs.
 */
public class Utils {

    /** Directory for storing uploaded images. */
    private static final String UPLOAD_DIR = "D:\\images";

    /**
     * Stores the uploaded photo and returns its URL.
     * @param photo MultipartFile representing the uploaded photo
     * @return String representing the URL of the stored photo
     */
    public static String storePhotoAndGetUrl(MultipartFile photo) {
        String fileName = StringUtils.cleanPath(photo.getOriginalFilename());
        String fileUrl = "";

        try {
            if (fileName.contains("..")) {
                throw new RuntimeException("Invalid file name!");
            }

            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            File imageFile = new File(uploadDir, fileName);
            try (FileOutputStream outputStream = new FileOutputStream(imageFile)) {
                outputStream.write(photo.getBytes());
            }

            fileUrl = generateFileUrl(imageFile.getName());
        } catch (IOException e) {
            e.printStackTrace();
        }

        return fileUrl;
    }

    /**
     * Generates the URL for the stored file.
     * @param fileName Name of the stored file
     * @return String representing the URL of the stored file
     */
    private static String generateFileUrl(String fileName) {
        return fileName;
    }
}