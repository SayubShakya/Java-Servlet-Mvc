package com.sayub.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {"/*"}) // Add more as needed
public class AuthFilter implements Filter {

    public void init(FilterConfig filterConfig) throws ServletException {
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        boolean isLoginRequest = req.getRequestURI().endsWith("login");
        boolean isRegisterRequest = req.getRequestURI().endsWith("register");
        boolean isTotpRequest = req.getRequestURI().endsWith("totp");

        if (isRegisterRequest || isTotpRequest) {
            chain.doFilter(request, response);
            return;
        }

        boolean loggedIn = (session != null && session.getAttribute("currentUser") != null);

        if(loggedIn && isLoginRequest) {
            res.sendRedirect("dashboard");
        }

        if(loggedIn && isTotpRequest) {
            res.sendRedirect("dashboard");
        }


        if(!loggedIn && isLoginRequest){
            chain.doFilter(request, response);
            return;
        }

        if (loggedIn) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect("login");
        }
    }
}
