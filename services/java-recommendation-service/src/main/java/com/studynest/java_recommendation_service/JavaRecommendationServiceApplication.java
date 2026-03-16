package com.studynest.java_recommendation_service;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

// start the spring boot app and scan the shared studynest packages.
@SpringBootApplication(scanBasePackages = "com.studynest")
public class JavaRecommendationServiceApplication {

    public static void main(String[] args) {
        // boot the grpc recommendation service.
        SpringApplication.run(JavaRecommendationServiceApplication.class, args);
    }
}
