/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sayub.controller;

import com.sayub.exception.ApplicationException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

import java.io.IOException;

public abstract class Controller extends HttpServlet {
    protected String viewPrefix = "/WEB-INF/views/";
    protected String viewSuffix = ".jsp";
    private static final Logger log = Logger.getLogger(Controller.class);

    protected void view(String page, HttpServletRequest request, HttpServletResponse response) {
        try {
            request.getRequestDispatcher(viewPrefix + page + viewSuffix).forward(request, response);
        } catch (ServletException e) {
            System.out.println("ServletException: " + e);
        } catch (IOException e) {
            System.out.println("IOException: " + e);
        }
    }

    protected void redirect(HttpServletRequest request, HttpServletResponse response, String page) {
        try {
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/" + page);
        } catch (IOException e) {
            System.out.println("IOException: " + e);
        }
    }

    protected void handleResponse(HttpServletRequest request, HttpServletResponse response, Runnable task) {
        try {
            task.run();
        } catch (ApplicationException e) {
            log.error("ApplicationException: ", e);
            view("500", request, response);
        } catch (Exception e) {
            log.error("Exception: ", e);
            view("500", request, response);
        }
    }

}