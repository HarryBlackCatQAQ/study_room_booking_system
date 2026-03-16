package com.studynest.java_recommendation_service;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

// start the application context to check that the service boots correctly.
@SpringBootTest(properties = "spring.grpc.server.port=0")
class JavaRecommendationServiceApplicationTests {

	@Test
	void contextLoads() {
		// this test passes when spring can create the application context.
	}

}
