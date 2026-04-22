package com.xiang.ai.autoQ;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
@EnableAsync // 开启异步调用
@MapperScan("com.xiang.ai.autoQ.mapper")
@EnableAspectJAutoProxy(exposeProxy = true) // 开启 AOP
public class AIAutoQBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(AIAutoQBackendApplication.class, args);
    }

}
