package com.graduationproject.utils;

import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class Utils {

    private static final String UPLOAD_DIR = "D:\\images";

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
            }  fileUrl = generateFileUrl(imageFile.getName());
        } catch (IOException e) {
            e.printStackTrace();
        }

        return fileUrl;
    }

    private static String generateFileUrl(String fileName) {
        return fileName;
    }
}
