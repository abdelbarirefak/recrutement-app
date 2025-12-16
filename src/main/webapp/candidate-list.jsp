<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.recrutement.entity.Candidate" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8"/>
    <title>Liste des Candidats - JobBoard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>body { font-family: 'Inter', sans-serif; }</style>
</head>
<body class="bg-slate-50 text-slate-900 p-8 min-h-screen">
    
    <div class="max-w-6xl mx-auto">
        <div class="flex justify-between items-center mb-8">
            <div>
                <h1 class="text-3xl font-bold tracking-tight">Candidats inscrits</h1>
                <p class="text-slate-500 mt-1">Profils disponibles pour vos offres.</p>
            </div>
            <a href="dashboard.jsp" class="px-4 py-2 bg-white border border-slate-200 rounded-lg text-sm font-medium hover:bg-slate-50 shadow-sm transition-colors">
                ← Retour au tableau de bord
            </a>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            <% 
                List<Candidate> candidates = (List<Candidate>) request.getAttribute("candidateList");
                if (candidates != null && !candidates.isEmpty()) {
                    for (Candidate c : candidates) {
            %>
            <div class="bg-white p-6 rounded-xl border border-slate-200 shadow-sm hover:shadow-md transition-all">
                <div class="flex items-start gap-4 mb-4">
                    <div class="w-12 h-12 bg-indigo-50 rounded-full flex items-center justify-center text-indigo-600 font-bold text-lg">
                        <%= c.getFirstName() != null ? c.getFirstName().substring(0,1) : "?" %>
                    </div>
                    <div>
                        <h3 class="text-lg font-bold text-slate-900"><%= c.getFirstName() %> <%= c.getLastName() %></h3>
                        <p class="text-sm text-indigo-600 font-medium"><%= c.getTitle() != null ? c.getTitle() : "Candidat" %></p>
                    </div>
                </div>
                
                <div class="space-y-2 text-sm text-slate-600 mb-6">
                    <p class="flex items-center gap-2">
                        <span>📧</span> <%= c.getUser().getEmail() %>
                    </p>
                    <% if(c.getPhone() != null) { %>
                    <p class="flex items-center gap-2">
                        <span>📞</span> <%= c.getPhone() %>
                    </p>
                    <% } %>
                </div>

                <button class="w-full py-2 bg-slate-900 text-white rounded-lg text-sm font-medium hover:bg-slate-800 transition-colors">
                    Contacter
                </button>
            </div>
            <% 
                    }
                } else {
            %>
            <div class="col-span-full text-center py-12 bg-white rounded-xl border border-dashed border-slate-300">
                <p class="text-slate-500">Aucun candidat n'est inscrit pour le moment.</p>
            </div>
            <% } %>
        </div>
    </div>
</body>
</html>