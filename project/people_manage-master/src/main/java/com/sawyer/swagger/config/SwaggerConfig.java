package com.sawyer.swagger.config;

import com.sawyer.swagger.controller.UserController;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.util.ArrayList;

@Configuration
@EnableSwagger2
public class SwaggerConfig {

    @Bean
    public Docket docket(){
        return new Docket(DocumentationType.SWAGGER_2)
                .apiInfo(apiInfo())
                .groupName("人事管理wxh")
                //.enable(false)是否启用Swagger
                .select()
                //RequestHandlerSelectors,配置要扫描接口的方式
                //basePackage:指定要扫描的包
                //any():扫描全部
                //none():不扫描
                //withClassAnnotation:扫描类上的注解
                //withMethodAnnotation:扫描方法上上的注解
                .apis(RequestHandlerSelectors.basePackage("com.sawyer.swagger.controller"))
                //paths()过滤路径
                //.paths(PathSelectors.ant())
                .build();
    }
    private ApiInfo apiInfo(){
        //作者信息
        Contact contact = new Contact("wxh","urn:tos","3258298771@qq.com");

        return new ApiInfo(
                "我的Api Documentation",
                "Api Documentation",
                "1.0",
                "urn:tos",
                contact,
                "Apache 2.0",
                "http://www.apache.org/licenses/LICENSE-2.0",
                new ArrayList()
        );
    }

}
