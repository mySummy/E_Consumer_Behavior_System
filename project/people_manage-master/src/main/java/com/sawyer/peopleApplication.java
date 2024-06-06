package com.sawyer;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan(value = "com.sawyer.dao")
public class peopleApplication {

    public static void main(String[] args) {
        SpringApplication.run(peopleApplication.class, args);
    }

}
