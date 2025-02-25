<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${prodotto.id == null ? 'Nuovo Prodotto' : 'Modifica Prodotto'}</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-blue-50">

<!-- Navbar con il nome dell'azienda centrato -->
<nav class="bg-blue-800 p-4 shadow-lg">
    <div class="container mx-auto flex justify-center items-center">
        <a href="/admin/" class="text-white text-4xl font-extrabold tracking-wider">
            ByteBazaar - Admin
        </a>
    </div>
</nav>

<!-- Contenitore principale -->
<div class="container mx-auto mt-8 p-6 bg-white shadow-lg rounded-lg max-w-4xl">
    <h1 class="text-2xl font-bold text-blue-700 mb-6">${prodotto.id == null ? 'Nuovo Prodotto' : 'Modifica Prodotto'}</h1>

    <!-- Form per creare/modificare un prodotto -->
    <form action="/admin/catalogo/prodotti/salva" method="post" class="space-y-4">
        <input type="hidden" name="id" value="${prodotto.id}" />

        <div>
            <label for="nome" class="block text-sm font-medium text-gray-700">Nome:</label>
            <input type="text" name="nome" id="nome" value="${prodotto.nome}" required class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2 focus:ring-blue-500 focus:border-blue-500"/>
        </div>

        <div>
            <label for="descrizione" class="block text-sm font-medium text-gray-700">Descrizione:</label>
            <textarea name="descrizione" id="descrizione" rows="4" class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2 focus:ring-blue-500 focus:border-blue-500">${prodotto.descrizione}</textarea>
        </div>

        <div>
            <label for="prezzo" class="block text-sm font-medium text-gray-700">Prezzo:</label>
            <input type="number" name="prezzo" id="prezzo" value="${prodotto.prezzo != null ? prodotto.prezzo : '0'}" required class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2 focus:ring-blue-500 focus:border-blue-500"/>
        </div>

        <div>
            <label for="marchio" class="block text-sm font-medium text-gray-700">Marchio:</label>
            <input type="text" name="marchio" id="marchio" value="${prodotto.marchio}" required class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2 focus:ring-blue-500 focus:border-blue-500"/>
        </div>

        <div>
            <label for="categoria" class="block text-sm font-medium text-gray-700">Categoria:</label>
            <input type="text" name="categoria" id="categoria" value="${prodotto.categoria}" required class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2 focus:ring-blue-500 focus:border-blue-500"/>
        </div>

        <div>
            <label for="quantitaMagazzino" class="block text-sm font-medium text-gray-700">Quantità Magazzino:</label>
            <input type="number" name="quantitaMagazzino" id="quantitaMagazzino" value="${prodotto.quantitaMagazzino != null ? prodotto.quantitaMagazzino : '0'}" required class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2 focus:ring-blue-500 focus:border-blue-500"/>
        </div>

        <div class="flex items-center">
            <input type="checkbox" name="inPromozione" id="inPromozione" ${prodotto.inPromozione ? 'checked' : ''} class="h-4 w-4 text-blue-600 border-gray-300 rounded focus:ring-blue-500"/>
            <label for="inPromozione" class="ml-2 block text-sm font-medium text-gray-700">In Promozione</label>
        </div>

        <div>
            <label for="imageUrl" class="block text-sm font-medium text-gray-700">URL Immagine:</label>
            <input type="text" name="imageUrl" id="imageUrl" value="${prodotto.imageUrl}" class="mt-1 block w-full border border-gray-300 rounded-md shadow-sm p-2 focus:ring-blue-500 focus:border-blue-500"/>
        </div>

        <div class="flex justify-between items-center">
            <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 transition duration-300">Salva</button>
            <a href="/admin/catalogo/prodotti" class="text-blue-600 hover:text-blue-800 transition duration-300">Torna al catalogo</a>
        </div>
    </form>
</div>

</body>
</html>
