package ru.ifmo.erp.foodtohome.config;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@ComponentScan("ru.ifmo.erp.foodtohome")
@EnableAutoConfiguration
@SpringBootApplication
public class FoodtohomeApplication {

	public static void main(String[] args) {
		ApplicationContext ctx = SpringApplication.run(
				FoodtohomeApplication.class,
				args
		);
	}
}
