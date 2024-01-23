package com.multi.tayotayo.member;


import java.util.concurrent.TimeUnit;

import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.AnnotationConfigApplicationContext;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;

@Service
public class RedisExample {
		ConfigurableApplicationContext ctx = new AnnotationConfigApplicationContext(RedisConfig.class);
		
		@SuppressWarnings("unchecked")
		RedisTemplate<String, String> redisTemplate = (RedisTemplate<String, String>)ctx.getBean("redisTemplate");
		

		
		public String getData(String key) {  
	        ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();  
	        return valueOperations.get(key);  
	    }  
	  
	    public boolean existData(String key) {  
	        return Boolean.TRUE.equals(redisTemplate.hasKey(key));  
	    }  
	  
	    public void setDataExpire(String key, String value) {  
	        ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();  
	        valueOperations.set(key, value, 300, TimeUnit.SECONDS);  //만료시간 5분
	    }  
	  
	    public void deleteData(String key) {  
	    	redisTemplate.delete(key);  
	    }  
		
}