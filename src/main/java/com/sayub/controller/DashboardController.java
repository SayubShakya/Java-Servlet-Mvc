package com.sayub.controller;

import com.sayub.entity.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.log4j.Logger;

@WebServlet("/dashboard")
public class DashboardController extends Controller {
    private static final Logger log = Logger.getLogger(DashboardController.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        handleResponse(request, response, () -> {
            try {
                HttpSession session = request.getSession(false);
                User user = (User) session.getAttribute("loggedInUser");

                request.setAttribute("user", user);

                switch (user.getRoleId()) {
                    case 1:
                        view("dashboard", request, response);
                        break;
                    case 2:
                        view("editorDashboard", request, response);
                        break;
                    case 3:
                        view("viewerDashboard", request, response);
                        break;
                    default:
                        response.sendError(HttpServletResponse.SC_FORBIDDEN, "Unauthorized access");
                }
            } catch (Exception e) {
                log.error("Exception in DashboardController: ", e);
                view("500", request, response);
            }
        });
    }
}