package com.recrutement.controller;

import com.recrutement.dao.CandidateDAO;
import com.recrutement.entity.Candidate;
import com.recrutement.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/candidates")
public class CandidateListServlet extends HttpServlet {
    
    private CandidateDAO candidateDAO = new CandidateDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Vérifier si l'utilisateur est connecté et est une Entreprise
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        // Note: Assurez-vous que le rôle dans la base de données correspond bien à "ENTERPRISE"
        if (user == null || !"ENTERPRISE".equals(user.getRole().toString())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Récupérer la liste des candidats depuis la base de données
        List<Candidate> candidates = candidateDAO.findAll();
        
        // 3. Envoyer la liste à la page JSP
        request.setAttribute("candidateList", candidates);
        request.getRequestDispatcher("candidate-list.jsp").forward(request, response);
    }
}