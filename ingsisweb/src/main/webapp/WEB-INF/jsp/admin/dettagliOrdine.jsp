<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dettagli Ordine #${ordine.id}</title>
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

<!-- Dettagli Ordine -->
<div class="container mx-auto mt-8 p-6 bg-white shadow-lg rounded-lg max-w-4xl">
    <h1 class="text-2xl font-bold text-blue-700 mb-4">Dettagli Ordine #${ordine.id}</h1>

    <div class="space-y-2 mb-4">
        <p><strong>Utente:</strong> ${ordine.utente.email}</p>
        <p><strong>Data Creazione:</strong> <fmt:formatDate value="${ordine.dataCreazione}" pattern="dd-MM-yyyy HH:mm"/></p>
        <p><strong>Indirizzo di Spedizione:</strong> ${ordine.indirizzoSpedizione}</p>
        <p><strong>Stato Ordine:</strong> ${ordine.statoOrdine}</p>
        <p><strong>Totale Scontato:</strong> <fmt:formatNumber value="${ordine.totale}" type="currency"/> €</p>
    </div>

    <h2 class="text-xl font-bold text-blue-700 mb-4">Prodotti Ordinati</h2>

    <div class="space-y-2">
        <c:forEach var="articolo" items="${articoli}">
            <div class="p-2 bg-gray-100 shadow rounded-lg flex justify-between items-center max-w-full">
                <div class="text-sm">
                    <h3 class="font-semibold text-blue-700">${articolo.prodotto.nome}</h3>
                    <p><strong>Quantità:</strong> ${articolo.quantita}</p>
                    <p><strong>Prezzo Unitario:</strong> <fmt:formatNumber value="${articolo.prezzo}" type="currency"/> €</p>
                </div>
                <div class="text-sm">
                    <p class="font-semibold"><strong>Totale:</strong> <fmt:formatNumber value="${articolo.prezzo * articolo.quantita}" type="currency"/> €</p>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

</body>
</html>
