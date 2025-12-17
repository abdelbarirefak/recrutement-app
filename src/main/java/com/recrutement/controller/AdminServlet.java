package com.recrutement.controller;

import com.recrutement.dao.ApplicationDAO;
import com.recrutement.dao.JobOfferDAO;
import com.recrutement.dao.UserDAO;
import com.recrutement.entity.Application;
import com.recrutement.entity.JobOffer;
import com.recrutement.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();
    private JobOfferDAO jobOfferDAO = new JobOfferDAO();
    private ApplicationDAO applicationDAO = new ApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        if (user == null || !"ADMIN".equals(user.getRole().toString())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 1. Charger TOUTES les données pour le dashboard
        List<User> users = userDAO.findAll();
        List<JobOffer> offers = jobOfferDAO.findAll();
        List<Application> applications = applicationDAO.findAll();
        
        // 2. Envoyer à la JSP
        request.setAttribute("userList", users);
        request.setAttribute("offerList", offers);
        request.setAttribute("appList", applications);
        
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        try {
            if ("validate_user".equals(action)) {
                long userId = Long.parseLong(request.getParameter("id"));
                User u = userDAO.findById(userId);
                if (u != null) {
                    u.setValidated(true);
                    userDAO.update(u);
                }
            } 
            else if ("delete_user".equals(action)) {
                long userId = Long.parseLong(request.getParameter("id"));
                userDAO.delete(userId);
            }
            else if ("delete_offer".equals(action)) {
                long offerId = Long.parseLong(request.getParameter("id"));
                jobOfferDAO.delete(offerId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Recharger la page pour voir les changements
        response.sendRedirect("admin");
    }
}