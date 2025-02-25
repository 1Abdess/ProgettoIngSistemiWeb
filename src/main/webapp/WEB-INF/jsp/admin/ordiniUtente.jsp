<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Ordini Utente</title>
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
  <h1 class="text-2xl font-bold text-blue-700 mb-6">Ordini per l'utente</h1>

  <!-- Messaggio di errore -->
  <c:if test="${not empty messaggioErrore}">
    <p class="text-red-600 mb-4">${messaggioErrore}</p>
  </c:if>

  <!-- Lista degli ordini -->
  <div class="space-y-4">
    <c:forEach var="ordine" items="${ordini}">
      <div class="p-4 bg-gray-100 shadow-sm rounded-lg flex justify-between items-center">
        <div class="text-sm">
          <p><strong>ID Ordine:</strong> ${ordine.id}</p>
          <p><strong>Totale:</strong> <fmt:formatNumber value="${ordine.totale}" type="currency" currencySymbol="€"/></p>
          <p><strong>Stato:</strong> ${ordine.statoOrdine}</p>
          <p><strong>Indirizzo Spedizione:</strong> ${ordine.indirizzoSpedizione}</p>
          <p><strong>Data Creazione:</strong> <fmt:formatDate value="${ordine.dataCreazione}" pattern="dd/MM/yyyy HH:mm"/></p>
        </div>
      </div>
    </c:forEach>
  </div>

  <!-- Link per tornare alla gestione utenti -->
  <div class="mt-8">
    <a href="/admin/utenti" class="text-blue-600 hover:underline">Torna alla gestione utenti</a>
  </div>
</div>

</body>
</html>
