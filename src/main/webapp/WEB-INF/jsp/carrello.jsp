<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html lang="it">
<head>
  <meta charset="UTF-8">
  <title>Il tuo carrello</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-blue-50">

<!-- Navbar -->
<nav class="bg-blue-800 p-4 shadow-lg">
  <div class="container mx-auto flex justify-center items-center">
    <a href="/" class="text-white text-4xl font-extrabold tracking-wider">
      ByteBazaar
    </a>
  </div>
</nav>

<div class="container mx-auto my-8 p-4 bg-white shadow-lg rounded-lg">

  <h2 class="text-2xl font-bold mb-4 text-blue-700">Il tuo carrello</h2>

  <!-- numero di articoli nel carrello -->
  <c:if test="${!articoli.isEmpty()}">
    <p>Hai <strong>${articoli.size()}</strong> articoli nel tuo carrello.</p>
  </c:if>

  <!-- Mostra un messaggio se il carrello è vuoto -->
  <c:if test="${carrelloVuoto}">
    <p>Il tuo carrello è vuoto. Vai al <a href="/">catalogo</a> per aggiungere prodotti.</p>
  </c:if>

  <!-- Mostra i prodotti nel carrello (se ci sono articoli) -->
  <c:if test="${!carrelloVuoto}">
    <div class="space-y-6">
      <c:forEach var="articolo" items="${articoli}">
        <div class="flex flex-col md:flex-row items-center bg-gray-100 p-4 rounded-lg shadow-sm">
          <div class="w-full md:w-1/3">
            <h3 class="text-xl font-semibold">${articolo.prodotto.nome}</h3>
            <p class="text-gray-600">Prezzo unitario: <fmt:formatNumber value="${articolo.prodotto.prezzo}" type="currency"/></p>
          </div>
          <div class="w-full md:w-1/4 mt-4 md:mt-0">
            <form method="post" action="/carrello/modificaQuantita" class="flex items-center">
              <input type="hidden" name="idArticolo" value="${articolo.id}"/>
              <input type="number" name="quantita" value="${articolo.quantita}" min="1" max="${articolo.prodotto.quantitaMagazzino}" class="border rounded w-20 text-center"/>
              <button type="submit" class="ml-4 bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition duration-300">Aggiorna</button>
            </form>
            <c:if test="${articolo.quantita > articolo.prodotto.quantitaMagazzino}">
              <p class="text-red-500 mt-2">La quantità richiesta supera la disponibilità di ${articolo.prodotto.quantitaMagazzino} unità.</p>
            </c:if>
          </div>
          <div class="w-full md:w-1/4 mt-4 md:mt-0">
            <p class="text-gray-700">Totale: <fmt:formatNumber value="${articolo.prodotto.prezzo * articolo.quantita}" type="currency"/></p>
          </div>
          <div class="w-full md:w-1/4 mt-4 md:mt-0 flex justify-end">
            <form method="post" action="/carrello/rimuovi">
              <input type="hidden" name="idArticolo" value="${articolo.id}"/>
              <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 transition duration-300">Rimuovi</button>
            </form>
          </div>
        </div>
      </c:forEach>
    </div>

    <!-- Mostra il totale carrello e i coupon -->
    <div class="mt-8">
      <!-- Se non ci sono coupon applicati, mostra il campo per inserire il codice coupon -->
      <c:if test="${couponApplicati.isEmpty()}">
        <form method="post" action="/carrello/applicaCoupon" class="mt-4">
          <label for="codiceCoupon">Inserisci codice coupon:</label>
          <input type="text" id="codiceCoupon" name="codiceCoupon" class="border rounded w-full md:w-1/2 p-2"/>
          <button type="submit" class="mt-2 bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 transition duration-300">Applica</button>
        </form>
      </c:if>

      <!-- Mostra i coupon già applicati -->
      <c:if test="${!couponApplicati.isEmpty()}">
        <h3 class="text-lg font-semibold mt-4">Coupon applicati:</h3>
        <ul class="mt-2">
          <c:forEach var="couponOrdine" items="${couponApplicati}">
            <li>${couponOrdine.coupon.codice} - Sconto del ${couponOrdine.coupon.percentualeSconto}%
              <form method="post" action="/carrello/rimuoviCoupon" style="display:inline;">
                <input type="hidden" name="idCoupon" value="${couponOrdine.coupon.id}"/>
                <button type="submit" class="ml-2 text-red-500 hover:text-red-700 transition duration-300">Rimuovi</button>
              </form>
            </li>
          </c:forEach>
        </ul>
      </c:if>
    </div>

    <!-- Totale carrello -->
    <p class="mt-6 text-xl font-semibold">Totale carrello: <fmt:formatNumber value="${totaleSconto}" type="currency"/></p>

    <!-- Checkout form -->
    <h2 class="text-2xl font-bold mt-8 text-blue-700">Checkout</h2>
    <form method="post" action="/ordine/salva" class="mt-4">
      <label for="indirizzoSpedizione">Indirizzo di spedizione:</label>
      <input type="text" id="indirizzoSpedizione" name="indirizzoSpedizione" required class="border rounded w-full md:w-1/2 p-2"/>

      <label for="metodoPagamento" class="mt-4">Metodo di pagamento:</label>
      <select id="metodoPagamento" name="metodoPagamento" required class="border rounded w-full md:w-1/2 p-2 mt-2">
        <option value="carta_credito">Carta di Credito</option>
        <option value="paypal">PayPal</option>
        <option value="bonifico">Bonifico Bancario</option>
      </select>

      <button type="submit" class="mt-6 bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700 transition duration-300">Conferma Ordine</button>
    </form>
  </c:if>

  <!-- Wishlist -->
  <h2 class="text-2xl font-bold mt-12 text-blue-700">La tua Wishlist</h2>
  <c:if test="${listaDesideri.isEmpty()}">
    <p>La tua wishlist è vuota. Visita il <a href="/">catalogo</a> per aggiungere prodotti.</p>
  </c:if>

  <c:if test="${!listaDesideri.isEmpty()}">
    <div class="mt-4 space-y-4">
      <c:forEach var="desiderio" items="${listaDesideri}">
        <div class="flex justify-between items-center bg-gray-100 p-4 rounded-lg shadow-sm">
          <span>${desiderio.prodotto.nome}</span>
          <div class="flex space-x-4">
            <!-- Aggiungi alla wishlist -->
            <form method="post" action="/wishlist/aggiungiAlCarrello">
              <input type="hidden" name="idWishlist" value="${desiderio.id}"/>
              <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition duration-300">Aggiungi al carrello</button>
            </form>

            <!-- Rimuovi dalla wishlist -->
            <form method="post" action="/wishlist/rimuovi">
              <input type="hidden" name="idWishlist" value="${desiderio.id}"/>
              <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 transition duration-300">Rimuovi</button>
            </form>
          </div>
        </div>
      </c:forEach>
    </div>
  </c:if>

</div>
</body>
</html>
