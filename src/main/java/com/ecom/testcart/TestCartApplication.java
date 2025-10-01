package com.ecom.testcart;

import com.ecom.testcart.config.RsakeysConfig;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableFeignClients
@EnableConfigurationProperties(RsakeysConfig.class)
public class TestCartApplication {

	public static void main(String[] args) {
		SpringApplication.run(TestCartApplication.class, args);
	}

}
