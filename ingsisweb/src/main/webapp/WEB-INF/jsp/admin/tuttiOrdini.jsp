<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Elenco di tutti gli ordini</title>
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

<!-- Elenco Ordini -->
<div class="container mx-auto mt-12 p-6 bg-white shadow-lg rounded-lg">
    <h2 class="text-3xl font-bold text-blue-700 mb-6 text-center">Elenco di tutti gli ordini</h2>

    <div class="space-y-4">
        <c:forEach var="ordine" items="${ordini}">
            <div class="p-4 bg-gray-100 shadow rounded-lg flex justify-between items-center">
                <div>
                    <h3 class="text-xl font-semibold text-blue-700">Ordine ID: ${ordine.id}</h3>
                    <p><strong>Utente:</strong> ${ordine.utente.email}</p>
                    <p><strong>Data Creazione:</strong> <fmt:formatDate value="${ordine.dataCreazione}" pattern="dd-MM-yyyy HH:mm"/></p>
                    <p><strong>Totale:</strong> <fmt:formatNumber value="${ordine.totale}" type="currency"/></p>
                    <p><strong>Stato:</strong> ${ordine.statoOrdine}</p>
                </div>
                <div>
                    <a href="/admin/ordini/dettagli/${ordine.id}" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition duration-300">Dettagli</a>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>
