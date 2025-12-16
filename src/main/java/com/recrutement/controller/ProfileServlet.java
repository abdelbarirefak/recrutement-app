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

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    
    private CandidateDAO candidateDAO = new CandidateDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loggedUser");

        if (user == null || !"CANDIDATE".equals(user.getRole().toString())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Récupérer les données du formulaire
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String title = request.getParameter("title");
        String phone = request.getParameter("phone");

        // Trouver le candidat associé à l'utilisateur
        // Note: Vous devrez peut-être ajouter une méthode findByUser dans CandidateDAO
        // Pour l'instant, on suppose qu'on crée ou met à jour un candidat basique
        // Ceci est une version simplifiée, idéalement il faut récupérer l'objet existant
        Candidate candidate = new Candidate();
        candidate.setUser(user);
        candidate.setFirstName(firstName);
        candidate.setLastName(lastName);
        candidate.setTitle(title);
        candidate.setPhone(phone);
        
        // Sauvegarder (il faudra adapter votre DAO pour faire un update si existe déjà)
        candidateDAO.save(candidate);

        response.sendRedirect("dashboard.jsp?success=ProfileUpdated");
    }
}