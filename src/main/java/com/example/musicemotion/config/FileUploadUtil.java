package com.example.musicemotion.config;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.springframework.web.multipart.MultipartFile;

public class FileUploadUtil {
    private static final String UPLOAD_DIR = "src/main/resources/static/images/playlist";

    public static String uploadImage(MultipartFile file) throws IOException {
        // 파일 이름을 고유하게 생성
        String fileName =  file.getOriginalFilename();
        //java.util.UUID.randomUUID().toString() + "_" +
        // 파일 경로 생성
        Path uploadPath = Paths.get(UPLOAD_DIR);
        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        // 파일 저장
        Path filePath = uploadPath.resolve(fileName);
        Files.copy(file.getInputStream(), filePath);

        // 파일 경로 반환
        return fileName; 
    }
}
