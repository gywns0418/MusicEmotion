package com.example.musicemotion.config;

import java.io.IOException;



import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CustomAuthenticationFailureHandler implements AuthenticationFailureHandler {

	@Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException {
        // 실패 이유를 로그로 출력
        System.out.println("Login failed: " + exception.getMessage());

        // 에러 페이지로 리다이렉트
        response.sendRedirect("/member/login.do?error=true");
    }


}
