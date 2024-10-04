package com.example.musicemotion.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.musicemotion.member.service.CustomMeberDetailsService;


@Configuration
@EnableWebSecurity(debug = false)
public class SpringSecurityConfig {

    @Autowired
    private CustomMeberDetailsService customMemberDetailsService;

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.csrf(AbstractHttpConfigurer::disable)
            .authorizeHttpRequests(authz -> authz
                .requestMatchers("/admin/**").hasAuthority("ROLE_2")
                .requestMatchers("/**", "/css/**", "/img/**").permitAll()
                .anyRequest().authenticated())
            .formLogin(form -> form
            	    .loginPage("/member/login.do")
            	    .loginProcessingUrl("/login")
            	    .usernameParameter("user_id")
            	    .passwordParameter("password")
            	    .failureHandler(new CustomAuthenticationFailureHandler()) 
            	    .defaultSuccessUrl("/")
            	    .permitAll())
            .logout(logout -> logout
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                .logoutSuccessUrl("/")
                .invalidateHttpSession(true))
            .httpBasic(basic -> basic.disable());

        return http.build();
    }

    @Autowired
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(customMemberDetailsService)
            .passwordEncoder(bCryptPasswordEncoder());
    }

    @Bean
    public static BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
