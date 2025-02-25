<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-blue-50">
<!-- Navbar -->
<nav class="bg-blue-800 p-4 shadow-lg z-50">
    <div class="container mx-auto flex justify-between items-center">
        <!-- Titolo con reindirizzamento alla homepage -->
        <a href="/" class="text-white text-4xl font-extrabold tracking-wider shadow-lg rounded-md transition-all duration-300 ease-in-out">
            ByteBazaar
        </a>

        <!-- Menu a tendina per utenti loggati -->
        <c:if test="${pageContext.request.userPrincipal != null}">
            <div class="relative">
                <button class="text-white font-semibold rounded-md hover:text-blue-300 focus:outline-none focus:ring-2 focus:ring-blue-300 transition duration-300 ease-in-out">
                    Menu
                </button>
                <div class="hidden absolute right-0 mt-2 bg-white border rounded-lg shadow-lg w-48 z-50">
                    <ul class="text-black">
                        <li><a href="/carrello" class="block px-4 py-2 hover:bg-blue-100 transition duration-300">Carrello</a></li>
                        <li><a href="/ordine/storico" class="block px-4 py-2 hover:bg-blue-100 transition duration-300">Storico Ordini</a></li>
                        <c:if test="${ruoloUtente == 'ADMIN'}">
                            <li><a href="/admin/" class="block px-4 py-2 hover:bg-blue-100 transition duration-300">Pannello Admin</a></li>
                        </c:if>
                        <li><a href="/logout" class="block px-4 py-2 hover:bg-blue-100 transition duration-300">Log-Out</a></li>
                    </ul>
                </div>
            </div>
        </c:if>

        <!-- Icona per utenti non loggati -->
        <c:if test="${pageContext.request.userPrincipal == null}">
            <div class="relative">
                <button class="text-white font-semibold rounded-md hover:text-blue-300 focus:outline-none focus:ring-2 focus:ring-blue-300 transition duration-300 ease-in-out">
                    <!-- Icona per il menu -->
                    <img src="https://img.icons8.com/?size=60&id=98957&format=png" class="h-6 w-6">
                </button>
                <div class="hidden absolute right-0 mt-2 bg-white border rounded-lg shadow-lg w-48 z-50">
                    <ul class="text-black">
                        <li><a href="/registrazione" class="block px-4 py-2 hover:bg-blue-100 transition duration-300">Registrati</a></li>
                        <li><a href="/login" class="block px-4 py-2 hover:bg-blue-100 transition duration-300">Login</a></li>
                    </ul>
                </div>
            </div>
        </c:if>
    </div>
</nav>

<!-- Script per aprire il menu al clic -->
<script>
    document.querySelectorAll('button').forEach(function(button) {
        button.addEventListener('click', function() {
            const dropdown = this.nextElementSibling;
            dropdown.classList.toggle('hidden');
        });
    });
</script>

<!-- Controllo se l'utente è bloccato -->
<c:if test="${utenteBloccato}">
    <div class="container mx-auto mt-8 p-6 bg-white shadow-lg rounded-lg max-w-4xl text-center">
        <h2 class="text-2xl font-bold text-red-600">Account Bloccato</h2>
        <p class="text-gray-600">Il tuo account è bloccato. Contatta l'assistenza per maggiori dettagli.</p>
    </div>
</c:if>

<c:if test="${!utenteBloccato}">
    <!-- Sezione per i prodotti in promozione -->
    <section class="container mx-auto my-8">
        <h2 class="text-2xl font-bold mb-4 text-blue-700">Prodotti in Promozione</h2>
        <div class="grid grid-cols-4 gap-6">
            <c:forEach var="prodotto" items="${prodottiPromo}">
                <c:if test="${!prodotto.bloccato}">
                    <div class="bg-white p-4 shadow-lg rounded-lg min-h-full flex flex-col justify-between transform transition hover:scale-105 duration-300 ease-in-out">
                        <img src="${prodotto.imageUrl}" alt="${prodotto.nome}" class="w-full h-40 object-cover mb-4 rounded-lg">
                        <h3 class="text-xl font-semibold">${prodotto.nome}</h3>
                        <p class="text-gray-600">${prodotto.descrizione}</p>
                        <p class="text-blue-600 font-bold">Prezzo: €<fmt:formatNumber value="${prodotto.prezzo}" type="number" minFractionDigits="2"/></p>

                        <c:if test="${pageContext.request.userPrincipal != null}">
                            <form action="/carrello/aggiungi" method="post" class="mt-4">
                                <input type="hidden" name="idProdotto" value="${prodotto.id}">
                                <input type="number" name="quantita" min="1" max="${prodotto.quantitaMagazzino}" value="1" class="border rounded w-full mb-2">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition duration-300">Aggiungi al Carrello</button>
                            </form>

                            <!-- Separatore tratteggiato grigio chiaro -->
                            <hr class="border-t border-dashed border-gray-300 my-4">

                            <form action="/wishlist/aggiungi" method="post" class="mt-2">
                                <input type="hidden" name="idProdotto" value="${prodotto.id}">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 transition duration-300">Aggiungi alla Wishlist</button>
                            </form>
                        </c:if>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </section>

    <!-- Filtro di Ricerca -->
    <section id="filtroProdotti" class="container mx-auto my-8">
        <h2 class="text-2xl font-bold mb-4 text-blue-700">Catalogo Prodotti</h2>
        <form action="/" method="get" class="mb-8 grid grid-cols-3 gap-4" action="/#filtroProdotti">
            <div>
                <label for="categoria" class="block mb-2">Categoria:</label>
                <select name="categoria" id="categoria" class="border rounded w-full">
                    <option value="">Tutte le categorie</option>
                    <c:forEach var="categoria" items="${categorie}">
                        <option value="${categoria}" <c:if test="${param.categoria == categoria}">selected</c:if>>${categoria}</option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <label for="marchio" class="block mb-2">Marchio:</label>
                <select name="marchio" id="marchio" class="border rounded w-full">
                    <option value="">Tutti i marchi</option>
                    <c:forEach var="marchio" items="${marchi}">
                        <option value="${marchio}" <c:if test="${param.marchio == marchio}">selected</c:if>>${marchio}</option>
                    </c:forEach>
                </select>
            </div>
            <div>
                <label for="ricerca" class="block mb-2">Ricerca libera:</label>
                <input type="text" name="ricerca" id="ricerca" value="${param.ricerca}" class="border rounded w-full">
            </div>
            <div>
                <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded mt-6 hover:bg-blue-700 transition duration-300">Filtra</button>
            </div>
        </form>

        <!-- Sezione per i prodotti filtrati -->
        <div class="grid grid-cols-4 gap-6">
            <c:forEach var="prodotto" items="${prodotti}">
                <c:if test="${!prodotto.bloccato}">
                    <div class="bg-white p-4 shadow-lg rounded-lg min-h-full flex flex-col justify-between transform transition hover:scale-105 duration-300 ease-in-out">
                        <img src="${prodotto.imageUrl}" alt="${prodotto.nome}" class="w-full h-40 object-cover mb-4 rounded-lg">
                        <h3 class="text-xl font-semibold">${prodotto.nome}</h3>
                        <p class="text-gray-600">${prodotto.descrizione}</p>
                        <p class="text-blue-600 font-bold">Prezzo: €<fmt:formatNumber value="${prodotto.prezzo}" type="number" minFractionDigits="2"/></p>

                        <c:if test="${pageContext.request.userPrincipal != null}">
                            <form action="/carrello/aggiungi" method="post" class="mt-4">
                                <input type="hidden" name="idProdotto" value="${prodotto.id}">
                                <input type="number" name="quantita" min="1" max="${prodotto.quantitaMagazzino}" value="1" class="border rounded w-full mb-2">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition duration-300">Aggiungi al Carrello</button>
                            </form>

                            <!-- Separatore tratteggiato grigio chiaro -->
                            <hr class="border-t border-dashed border-gray-300 my-4">

                            <form action="/wishlist/aggiungi" method="post" class="mt-2">
                                <input type="hidden" name="idProdotto" value="${prodotto.id}">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 transition duration-300">Aggiungi alla Wishlist</button>
                            </form>
                        </c:if>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </section>
</c:if>
</body>
</html>
