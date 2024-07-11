package com.example.libraryManagement.auth.filter;

import io.jsonwebtoken.JwtException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class HandlerExceptionFilter extends OncePerRequestFilter {
    private final Logger logger = LoggerFactory.getLogger(HandlerExceptionFilter.class);
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        try {
            filterChain.doFilter(request, response);
        } catch (JwtException exception){
            logger.atInfo().log("request's uri: "+ request.getRequestURI());
            logger.info(exception.getMessage());
            throw new RuntimeException("Jwt error");
        }
    }
}
