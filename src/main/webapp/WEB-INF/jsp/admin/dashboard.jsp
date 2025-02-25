<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="it">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dashboard Admin</title>
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

<!-- Dashboard Admin -->
<div class="container mx-auto mt-8 p-6 bg-white shadow-lg rounded-lg max-w-4xl">
  <h1 class="text-2xl font-bold text-700 mb-6">Dashboard Amministratore</h1>

  <div class="grid grid-cols-1 gap-4">
    <a href="/admin/utenti" class="bg-blue-600 text-white text-center px-4 py-2 rounded hover:bg-blue-700 transition duration-300">
      Gestione Utenti
    </a>
    <a href="/admin/catalogo/prodotti" class="bg-blue-600 text-white text-center px-4 py-2 rounded hover:bg-blue-700 transition duration-300">
      Gestione Prodotti
    </a>
    <a href="/admin/ordini" class="bg-blue-600 text-white text-center px-4 py-2 rounded hover:bg-blue-700 transition duration-300">
      Gestione Ordini
    </a>
  </div>
</div>

</body>
</html>
