<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.recrutement.entity.User, com.recrutement.entity.JobOffer, com.recrutement.entity.Application" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="utf-8"/>
    <title>Administration Complète - JobBoard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/lucide@latest"></script>
    <style>body { font-family: 'Inter', sans-serif; }</style>
</head>
<body class="bg-gray-100 min-h-screen p-6">

    <div class="max-w-7xl mx-auto space-y-8">
        
        <div class="flex justify-between items-center bg-white p-6 rounded-xl shadow-sm">
            <div>
                <h1 class="text-2xl font-bold text-slate-900 flex items-center gap-2">
                    <i data-lucide="shield-check" class="text-indigo-600"></i> Administration
                </h1>
                <p class="text-slate-500 text-sm">Gérez les utilisateurs, les offres et les candidatures.</p>
            </div>
            <a href="index.jsp" class="text-red-600 hover:bg-red-50 px-4 py-2 rounded-lg font-medium transition flex items-center gap-2">
                <i data-lucide="log-out" class="w-4 h-4"></i> Déconnexion
            </a>
        </div>

        <% 
            List<User> users = (List<User>) request.getAttribute("userList"); 
            List<JobOffer> offers = (List<JobOffer>) request.getAttribute("offerList");
            List<Application> apps = (List<Application>) request.getAttribute("appList");
        %>

        <div class="bg-white rounded-xl shadow-sm overflow-hidden border border-slate-200">
            <div class="p-4 bg-slate-50 border-b border-slate-200 flex justify-between items-center">
                <h2 class="font-bold text-slate-800 flex items-center gap-2">
                    <i data-lucide="building-2" class="w-5 h-5 text-indigo-600"></i> Entreprises
                </h2>
                <span class="bg-indigo-100 text-indigo-800 text-xs font-bold px-2 py-1 rounded">Recruteurs</span>
            </div>
            <table class="w-full text-left text-sm">
                <thead class="bg-white text-slate-500 border-b">
                    <tr>
                        <th class="p-4">Email / ID</th>
                        <th class="p-4">Statut</th>
                        <th class="p-4 text-right">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    <% if(users != null) { for(User u : users) { if(!"ENTERPRISE".equals(u.getRole().toString())) continue; %>
                    <tr class="hover:bg-slate-50">
                        <td class="p-4">
                            <div class="font-bold text-slate-900"><%= u.getEmail() %></div>
                            <div class="text-xs text-slate-400">ID: <%= u.getId() %></div>
                        </td>
                        <td class="p-4">
                            <% if(u.isValidated()) { %>
                                <span class="text-emerald-600 flex items-center gap-1"><i data-lucide="check" class="w-3 h-3"></i> Validé</span>
                            <% } else { %>
                                <span class="text-orange-600 flex items-center gap-1"><i data-lucide="clock" class="w-3 h-3"></i> En attente</span>
                            <% } %>
                        </td>
                        <td class="p-4 text-right flex justify-end gap-2">
                            <% if(!u.isValidated()) { %>
                            <form action="admin" method="POST">
                                <input type="hidden" name="action" value="validate_user">
                                <input type="hidden" name="id" value="<%= u.getId() %>">
                                <button class="bg-emerald-600 text-white px-3 py-1.5 rounded hover:bg-emerald-700">Valider</button>
                            </form>
                            <% } %>
                            <form action="admin" method="POST" onsubmit="return confirm('Supprimer ce compte ?');">
                                <input type="hidden" name="action" value="delete_user">
                                <input type="hidden" name="id" value="<%= u.getId() %>">
                                <button class="bg-red-100 text-red-600 px-3 py-1.5 rounded hover:bg-red-200">Supprimer</button>
                            </form>
                        </td>
                    </tr>
                    <% }} %>
                </tbody>
            </table>
        </div>

        <div class="bg-white rounded-xl shadow-sm overflow-hidden border border-slate-200">
            <div class="p-4 bg-slate-50 border-b border-slate-200 flex justify-between items-center">
                <h2 class="font-bold text-slate-800 flex items-center gap-2">
                    <i data-lucide="users" class="w-5 h-5 text-blue-600"></i> Candidats
                </h2>
                <span class="bg-blue-100 text-blue-800 text-xs font-bold px-2 py-1 rounded">Candidats</span>
            </div>
            <table class="w-full text-left text-sm">
                <thead class="bg-white text-slate-500 border-b">
                    <tr>
                        <th class="p-4">Email / ID</th>
                        <th class="p-4">Statut</th>
                        <th class="p-4 text-right">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    <% if(users != null) { for(User u : users) { if(!"CANDIDATE".equals(u.getRole().toString())) continue; %>
                    <tr class="hover:bg-slate-50">
                        <td class="p-4">
                            <div class="font-bold text-slate-900"><%= u.getEmail() %></div>
                            <div class="text-xs text-slate-400">ID: <%= u.getId() %></div>
                        </td>
                        <td class="p-4">
                            <% if(u.isValidated()) { %>
                                <span class="text-emerald-600 flex items-center gap-1"><i data-lucide="check" class="w-3 h-3"></i> Validé</span>
                            <% } else { %>
                                <span class="text-orange-600 flex items-center gap-1"><i data-lucide="clock" class="w-3 h-3"></i> En attente</span>
                            <% } %>
                        </td>
                        <td class="p-4 text-right flex justify-end gap-2">
                            <% if(!u.isValidated()) { %>
                            <form action="admin" method="POST">
                                <input type="hidden" name="action" value="validate_user">
                                <input type="hidden" name="id" value="<%= u.getId() %>">
                                <button class="bg-blue-600 text-white px-3 py-1.5 rounded hover:bg-blue-700">Valider</button>
                            </form>
                            <% } %>
                            <form action="admin" method="POST" onsubmit="return confirm('Supprimer ce candidat ?');">
                                <input type="hidden" name="action" value="delete_user">
                                <input type="hidden" name="id" value="<%= u.getId() %>">
                                <button class="bg-red-100 text-red-600 px-3 py-1.5 rounded hover:bg-red-200">Supprimer</button>
                            </form>
                        </td>
                    </tr>
                    <% }} %>
                </tbody>
            </table>
        </div>

        <div class="bg-white rounded-xl shadow-sm overflow-hidden border border-slate-200">
            <div class="p-4 bg-slate-50 border-b border-slate-200">
                <h2 class="font-bold text-slate-800 flex items-center gap-2">
                    <i data-lucide="briefcase" class="w-5 h-5 text-purple-600"></i> Toutes les Offres
                </h2>
                <p class="text-xs text-slate-500 mt-1">Vue globale pour modération.</p>
            </div>
            <table class="w-full text-left text-sm">
                <thead class="bg-white text-slate-500 border-b">
                    <tr>
                        <th class="p-4">Titre / Entreprise</th>
                        <th class="p-4">Lieu</th>
                        <th class="p-4 text-right">Action</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-100">
                    <% if(offers != null) { for(JobOffer offer : offers) { %>
                    <tr class="hover:bg-slate-50">
                        <td class="p-4">
                            <div class="font-bold text-slate-900"><%= offer.getTitle() %></div>
                            <div class="text-xs text-slate-500">
                                Recruteur ID: <%= offer.getRecruiter() != null ? offer.getRecruiter().getId() : "?" %>
                            </div>
                        </td>
                        <td class="p-4 text-slate-600"><%= offer.getLocation() %></td>
                        <td class="p-4 text-right">
                            <form action="admin" method="POST" onsubmit="return confirm('Supprimer cette offre ?');">
                                <input type="hidden" name="action" value="delete_offer">
                                <input type="hidden" name="id" value="<%= offer.getId() %>">
                                <button class="text-red-600 hover:text-red-800 font-medium text-xs border border-red-200 px-2 py-1 rounded">
                                    Supprimer (Modération)
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% }} else { %>
                    <tr><td colspan="3" class="p-4 text-center text-slate-500">Aucune offre publiée.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <div class="bg-white rounded-xl shadow-sm overflow-hidden border border-slate-200">
            <div class="p-4 bg-slate-50 border-b border-slate-200">
                <h2 class="font-bold text-slate-800 flex items-center gap-2">
                    <i data-lucide="file-text" class="w-5 h-5 text-gray-600"></i> Suivi des Candidatures
                </h2>
            </div>
            <div class="p-6">
                <div class="text-3xl font-bold text-slate-900 mb-2">
                    <%= (apps != null) ? apps.size() : 0 %>
                </div>
                <p class="text-slate-500 text-sm">Candidatures totales envoyées sur la plateforme.</p>
            </div>
        </div>

    </div>
    <script>lucide.createIcons();</script>
</body>
</html>