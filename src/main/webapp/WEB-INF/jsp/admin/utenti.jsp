<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestione Utenti</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-blue-50">

<!-- Navbar con solo il nome dell'azienda centrato -->
<nav class="bg-blue-800 p-4 shadow-lg">
    <div class="container mx-auto flex justify-center items-center">
        <a href="/admin/" class="text-white text-4xl font-extrabold tracking-wider">
            ByteBazaar - Admin
        </a>
    </div>
</nav>

<div class="container mx-auto mt-8 p-6 bg-white shadow-lg rounded-lg max-w-4xl">
    <h1 class="text-2xl font-bold text-blue-700 mb-6">Gestione Utenti</h1>

    <div class="space-y-4">
        <c:forEach var="utente" items="${utenti}">
            <div class="p-4 bg-gray-100 shadow-sm rounded-lg flex justify-between items-center">
                <div class="text-sm">
                    <p><strong>Email:</strong> ${utente.email}</p>
                    <p><strong>Nome Utente:</strong> ${utente.nomeUtente}</p>
                    <p><strong>Ruolo:</strong> ${utente.ruolo}</p>
                    <p><strong>Bloccato:</strong> <c:out value="${utente.bloccato}" /></p>
                </div>
                <div class="flex items-center space-x-4">
                    <form action="/admin/utenti/blocco" method="post">
                        <input type="hidden" name="email" value="${utente.email}" />
                        <c:choose>
                            <c:when test="${utente.bloccato}">
                                <button type="submit" name="azione" value="sblocca" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 transition">Sblocca</button>
                            </c:when>
                            <c:otherwise>
                                <button type="submit" name="azione" value="blocca" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 transition">Blocca</button>
                            </c:otherwise>
                        </c:choose>
                    </form>

                    <form action="/admin/utenti/ordini" method="get">
                        <input type="hidden" name="email" value="${utente.email}" />
                        <button type="submit" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition">Visualizza Ordini</button>
                    </form>

                    <!-- Linea tratteggiata in verticale tra "Visualizza Ordini" e il menu a tendina -->
                    <div class="border-l-2 border-dashed border-gray-300 h-8"></div>

                    <!-- Condizione per non permettere all'utente loggato di cambiare il proprio ruolo -->
                    <c:if test="${pageContext.request.userPrincipal != null && pageContext.request.userPrincipal.name != utente.email}">
                        <form action="/admin/utenti/ruolo" method="post">
                            <input type="hidden" name="email" value="${utente.email}" />
                            <select name="ruolo" class="border rounded px-2 py-1">
                                <option value="USER" <c:if test="${utente.ruolo == 'USER'}">selected</c:if>>Utente</option>
                                <option value="ADMIN" <c:if test="${utente.ruolo == 'ADMIN'}">selected</c:if>>Amministratore</option>
                            </select>
                            <button type="submit" class="bg-yellow-500 text-white px-4 py-2 rounded hover:bg-yellow-600 transition">Cambia Ruolo</button>
                        </form>
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>
