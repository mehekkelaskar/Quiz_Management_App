package web_initialization;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@Configuration
@ComponentScan({"controller_manag","email_verification","db_con"})
public class Config {
	@Bean
	public InternalResourceViewResolver view(){
		InternalResourceViewResolver i=new InternalResourceViewResolver();
		i.setPrefix("/WEB-INF/");
		i.setSuffix(".jsp");
		return i;
	}


}
