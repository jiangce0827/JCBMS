package com.jiangce.jcbms;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 启动程序
 * 
 * @author JCBMS
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class JcbmsApplication
{
    public static void main(String[] args)
    {
        // System.setProperty("spring.devtools.restart.enabled", "false");
        SpringApplication.run(JcbmsApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  JCBMS启动成功   ლ(´ڡ`ლ)ﾞ  \n");
    }
}
