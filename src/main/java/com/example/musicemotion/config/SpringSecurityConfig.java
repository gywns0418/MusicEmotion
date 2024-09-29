/*
 * package com.example.musicemotion.config;
 * 
 * import org.springframework.context.annotation.Bean; import
 * org.springframework.context.annotation.Configuration; import
 * org.springframework.security.config.annotation.web.builders.HttpSecurity;
 * import org.springframework.security.config.annotation.web.configurers.
 * AbstractHttpConfigurer; import
 * org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder; import
 * org.springframework.security.crypto.password.PasswordEncoder; import
 * org.springframework.security.web.SecurityFilterChain; import
 * org.springframework.security.web.util.matcher.AntPathRequestMatcher;
 * 
 * @Configuration public class SpringSecurityConfig {
 * 
 * @Bean public SecurityFilterChain filterChain(HttpSecurity http) throws
 * Exception { http.csrf(AbstractHttpConfigurer::disable)
 * .authorizeHttpRequests(authz -> authz
 * .requestMatchers("/admin/**").hasAuthority("ROLE_2")
 * .requestMatchers("/css/**", "/img/**", "/").permitAll() // 중복 제거
 * .anyRequest().authenticated()) .formLogin(form -> form
 * .loginPage("/member/login.do") .loginProcessingUrl("/login")
 * .defaultSuccessUrl("/") .permitAll()) .logout(logout -> logout
 * .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
 * .logoutSuccessUrl("/") .invalidateHttpSession(true)) .httpBasic(basic ->
 * basic.disable()); return http.build(); }
 * 
 * @Bean public PasswordEncoder passwordEncoder() { return new
 * BCryptPasswordEncoder(); } }
 */

