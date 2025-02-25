<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Storico Ordini</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-blue-50">

<!-- Navbar con solo il nome dell'azienda centrato -->
<nav class="bg-blue-800 p-4 shadow-lg">
  <div class="container mx-auto flex justify-center items-center">
    <a href="/" class="text-white text-4xl font-extrabold tracking-wider">
      ByteBazaar
    </a>
  </div>
</nav>

<!-- Storico Ordini -->
<div class="container mx-auto mt-12 p-6 bg-white shadow-lg rounded-lg">
  <h1 class="text-3xl font-bold text-blue-700 mb-6 text-center">Storico Ordini</h1>

  <!-- Mostra il messaggio se non ci sono ordini -->
  <c:if test="${ordini.isEmpty()}">
    <p class="text-center text-gray-700">Non hai ancora effettuato alcun ordine.</p>
  </c:if>

  <!-- Mostra gli ordini se presenti -->
  <c:if test="${!ordini.isEmpty()}">
    <div class="space-y-6">
      <c:forEach var="ordine" items="${ordini}">
        <div class="p-4 bg-gray-100 rounded-lg shadow-sm flex flex-col md:flex-row justify-between items-center">
          <!-- Dettagli ordine -->
          <div>
            <h2 class="text-xl font-semibold">Ordine #${ordine.id}</h2>
            <p class="text-gray-700">Stato: <span class="font-medium">${ordine.statoOrdine}</span></p>
            <p class="text-gray-600">Data: ${ordine.dataCreazione}</p>
          </div>

          <!-- Totale ordine -->
          <div class="mt-4 md:mt-0">
            <p class="text-lg font-semibold">Totale: € <fmt:formatNumber value="${ordine.totale}" type="currency"/></p>
          </div>
        </div>
      </c:forEach>
    </div>
  </c:if>

</div>

</body>
</html>
