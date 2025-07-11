package com.sayub.controller;

import com.sayub.exception.ApplicationException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;

import java.io.IOException;

public abstract class Controller extends HttpServlet {
    private static final Logger log = Logger.getLogger(Controller.class);
    protected String viewPrefix = "/WEB-INF/views/";
    protected String viewSuffix = ".jsp";

    protected void view(String path, HttpServletRequest request, HttpServletResponse response) {
        try {
            request.getRequestDispatcher(viewPrefix + path + viewSuffix).forward(request, response);
        } catch (ServletException e) {
            log.error("ServletException: ", e);
        } catch (IOException e) {
            log.error("IOException: ", e);
        }
    }

    protected void redirect(HttpServletRequest request, HttpServletResponse response, String page) {
        try {
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/" + page);
        } catch (IOException e) {
            log.error("IOException: ", e);
        }
    }

    protected void handleResponse(HttpServletRequest request, HttpServletResponse response, Runnable task) {
        try {
            task.run();
        } catch (ApplicationException e) {
            log.error("ApplicationException: ", e);
            view("common/500", request, response);
        } catch (Exception e) {
            log.error("Exception: ", e);
            view("common/500", request, response);
        }
    }
}