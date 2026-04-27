package com.xiang.ai.autoQ.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.*;

@Configuration
public class RedisConfig {

    /**
     * RedisTemplate 配置
     *
     * 说明：
     * 1. key 使用 String 序列化（可读性好）
     * 2. value 使用 JSON 序列化（避免 JDK 反序列化报错）
     * 3. hash 结构同样使用 JSON（统一）
     *
     * 优点：
     * - 避免 ClassNotFoundException（你刚刚那个坑）
     * - Redis 数据可读（不像 JDK 序列化是乱码）
     * - 跨服务/跨版本更安全
     */
    @Bean
    public RedisTemplate<String, Object> redisTemplate(RedisConnectionFactory factory) {
        // 创建 RedisTemplate
        RedisTemplate<String, Object> template = new RedisTemplate<>();

        // 设置连接工厂
        template.setConnectionFactory(factory);

        // ================= 序列化配置 =================

        // key 序列化：String
        StringRedisSerializer stringSerializer = new StringRedisSerializer();

        // value 序列化：JSON
        GenericJackson2JsonRedisSerializer jsonSerializer = new GenericJackson2JsonRedisSerializer();

        // key
        template.setKeySerializer(stringSerializer);

        // value
        template.setValueSerializer(jsonSerializer);

        // hash key
        template.setHashKeySerializer(stringSerializer);

        // hash value
        template.setHashValueSerializer(jsonSerializer);

        // ================= 初始化 =================
        template.afterPropertiesSet();

        return template;
    }
}