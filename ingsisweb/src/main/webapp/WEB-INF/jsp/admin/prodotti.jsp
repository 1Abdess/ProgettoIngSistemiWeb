<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Gestione Prodotti</title>
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

<div class="container mx-auto mt-8 p-6 bg-white shadow-lg rounded-lg max-w-6xl">
  <h1 class="text-2xl font-bold text-blue-700 mb-4">Gestione Prodotti</h1>

  <!-- Link per aggiungere un nuovo prodotto -->
  <div class="mb-6">
    <a href="/admin/catalogo/prodotti/nuovo" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 transition duration-300">Aggiungi Nuovo Prodotto</a>
  </div>

  <!-- Elenco prodotti -->
  <div class="space-y-4">
    <c:forEach var="prodotto" items="${prodotti}">
      <div class="p-4 bg-gray-100 shadow-sm rounded-lg flex justify-between items-center max-w-full">
        <div class="text-sm">
          <h3 class="font-semibold text-blue-700">${prodotto.nome}</h3>
          <p><strong>ID:</strong> ${prodotto.id}</p>
          <p><strong>Prezzo:</strong> <fmt:formatNumber value="${prodotto.prezzo}" type="currency" currencySymbol="€"/></p>
          <p><strong>Quantità in Magazzino:</strong> ${prodotto.quantitaMagazzino}</p>
          <p><strong>Categoria:</strong> ${prodotto.categoria}</p>
          <p><strong>Marchio:</strong> ${prodotto.marchio}</p>
          <p><strong>Bloccato:</strong> <c:out value="${prodotto.bloccato}"/></p>
        </div>
        <div class="flex space-x-4">
          <!-- Blocco/Sblocco prodotto -->
          <form action="/admin/catalogo/prodotti/blocco" method="post">
            <input type="hidden" name="id" value="${prodotto.id}" />
            <c:choose>
              <c:when test="${prodotto.bloccato}">
                <button type="submit" name="azione" value="sblocca" class="bg-yellow-600 text-white px-4 py-2 rounded hover:bg-yellow-700 transition duration-300">Sblocca</button>
              </c:when>
              <c:otherwise>
                <button type="submit" name="azione" value="blocca" class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 transition duration-300">Blocca</button>
              </c:otherwise>
            </c:choose>
          </form>
          <!-- Link per modificare il prodotto -->
          <a href="/admin/catalogo/prodotti/modifica/${prodotto.id}" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition duration-300">Modifica</a>
        </div>
      </div>
    </c:forEach>
  </div>

</div>

</body>
</html>
